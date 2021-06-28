module Elpresidente
  module Skills
    module Admin
      class Manage < Skill
        def execute
          return unless admin?
          return unless mentioned? || personal?

          case match?(/admin (?<command>.+) <@(?<user_id>.+)>$/)
          in { command: 'add', user_id: }
            blackboard.push('admins', user_id)
            react!('ok_hand')
            stop!
          in { command: 'remove', user_id: }
            blackboard.remove('admins', user_id)
            react!('ok_hand')
            stop!
          else
            skip!
          end
        end
      end
    end
  end
end