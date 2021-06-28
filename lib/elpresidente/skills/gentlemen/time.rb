module Elpresidente
  module Skills
    module Gentlemen
      class Time < Skill
        def execute
          return unless mentioned? || personal?
          return unless match?(/wiela na cykocu/)

          reply! "Aktualny czas to: #{::Time.now}"
          stop!
        end
      end
    end
  end
end