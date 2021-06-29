require 'dry/cli'
require 'elpresidente/controller'
require 'pry'

module Elpresidente
  module CLI
    extend Dry::CLI::Registry

    class Version < Dry::CLI::Command
      desc 'Print version'

      def call(*)
        puts Elpresidente::VERSION
      end
    end

    class Console < Dry::CLI::Command
      desc 'Start interactive console'

      def call
        Async do
          Elpresidente.loader.ready!(develop: true)
          Pry.start(LoaderContext.new)
        end
      end
    end

    class Start < Dry::CLI::Command
      desc 'Start bot'

      option :concurrency, type: :number, default: 10, desc: 'Number of processed messages', aliases: ['-c']
      option :debug, type: :boolean, default: false, desc: 'Print debug info'
      option :develop, type: :boolean, default: true, desc: 'Enable live reload for skills', aliases: ['-d']

      def call(concurrency:, debug:, develop:)
        Async.logger.debug! if debug

        Async do
          @controller = Elpresidente::Controller.new(
            concurrency: concurrency.to_i,
            develop: develop,
            redis_uri: URI.parse(ENV.fetch('REDIS_URI'))
          )
          @controller.wait
          @controller.run
        ensure
          @controller&.cleanup
        end
      end
    end

    register 'start', Start
    register 'console', Console
    register 'version', Version, aliases: ['v', '-v', '--version']
  end
end
