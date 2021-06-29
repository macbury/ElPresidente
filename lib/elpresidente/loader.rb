module Elpresidente
  class LoaderContext
    def reload!
      Elpresidente.loader.reload!
    end
  end

  class Loader
    def initialize
      @loader = Zeitwerk::Loader.new
      @loader.push_dir("#{__dir__}/skills", namespace: Elpresidente::Skills)
      @loader.push_dir("#{__dir__}/blackboard", namespace: Elpresidente::Blackboard)
      @loader.push_dir("#{__dir__}/services")
    end

    def ready!(develop:)
      if develop
        Async.logger.info 'Enabled live reload'
        @loader.enable_reloading
      end
      @develop = develop
      @loader.setup
      @loader.eager_load
    end

    def reload!
      @loader.reload if develop
    end

    private

    attr_reader :loader, :develop
  end
end