module Elpresidente
  class Controller < Async::Container::Controller
    def initialize(concurrency: 25, workers: 1, develop: false, redis_uri:)
      super(notify: Async::Container::Notify.open!)

      Elpresidente.loader.ready!(develop: develop)

      @redis = Async::Redis::Client.new(Async::IO::Endpoint.tcp(redis_uri.hostname, redis_uri.port))
      @internet = Async::HTTP::Internet.new
      @client = Slack::RealTime::Client.new
      @concurrency = concurrency
      @workers = workers
      @schedule = schedule
      @semaphore = Async::Semaphore.new(concurrency)
      @develop = develop
    end

    def setup(container)
      Async.logger.info 'Starting...'

      container.run(count: workers, restart: false) do |instance|
        container.async { |task| cron!(task) }
        container.async { |task| consume_events(task) }

        instance.ready!
      end
    end

    def cleanup
      Async.logger.error "Cleanup"
      internet.close
      redis.close
    end

    private

    attr_reader :concurrency, :workers, :semaphore, :client, :loader, :develop, :internet, :redis

    def cron!(task)
      loop do
        task.async do
          execution_time = Time.now
          execute_skill(Skills::Cron, { execution_time: execution_time }, task)
        end
        task.sleep 60
      end
    end

    def consume_events(task)
      Async.logger.info "Started, max concurrency is: #{concurrency}"

      client.on(:message) do |data|
        semaphore.async do |task|
          execute_skill(Skills::Start, data, task)
        end
      end

      client.start_async

      loop { task.sleep 60 }
    end

    def execute_skill(skill_class, data = {}, task = nil)
      Elpresidente.loader.reload!

      skill_class.execute(
        client: client, 
        data: data, 
        task: task, 
        internet: internet,
        blackboard: Blackboard::Skill.new(client: redis, data: data)
      )
    end
  end
end