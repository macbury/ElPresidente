module Elpresidente
  module Skills
    module Reactions
      class Manage < Skill
        def execute
          return unless admin?
          return unless mentioned? || personal?

          case match?(/reactions (?<command>.+) <@(?<user_id>.+)> :(?<emoji>.+):$/)
          in { command: 'add', user_id:, emoji: }
            blackboard.for_user(user_id).push('reactions', emoji)
            react!('ok_hand')
            stop!
          in { command: 'remove', user_id:, emoji: }
            blackboard.for_user(user_id).remove('reactions', emoji)
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