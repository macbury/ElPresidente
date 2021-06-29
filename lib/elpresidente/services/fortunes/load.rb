module Fortunes
  # Load fortunes from disk into memory
  class Load < Service
    SPLIT_FORTUNE = /^%$/i

    def initialize
      @barrier = Async::Barrier.new
    end

    def call
      info "Loading: #{fortunes_path}"
      tasks = Dir[fortunes_path].map do |path|
        next if File.directory?(path)

        barrier.async { load_fortunes(path) }
      end

      barrier.wait
      fortunes = tasks.map(&:result).flatten
      10.times { fortunes.shuffle! }
      fortunes
    end

    private

    attr_reader :barrier

    def load_fortunes(path)
      File.read(path).split(SPLIT_FORTUNE).map(&:strip)
    end

    def fortunes_path
      File.expand_path("#{__dir__}/../../../../fortunes/pl/**/*.*")
    end
  end
end