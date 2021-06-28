module Elpresidente
  module Skills
    module Admin
      class Start < Skill
        def execute
          return unless mentioned? || personal?
          return unless match?(/admin/i)

          sequence [
            Manage,
            List
          ]
        end
      end
    end
  end
end