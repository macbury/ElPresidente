module Elpresidente
  module Skills
    module Gentlemen
      class Hello < Skill
        def execute
          return unless mentioned? || personal?
          return unless match?(/hello/)

          reply! "Haraszo"
          stop!
        end
      end
    end
  end
end