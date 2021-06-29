module Elpresidente
  module Skills
    module Admin
      class List < Skill
        def execute
          return unless mentioned? || personal?
          return unless match?(/admin/i)

          reply!('Sztab:') do |block|
            people = blackboard.items('admins').map { |user_id| " - <@#{user_id}>" }.join("\n")

            block.section do |section|
              section.mrkdwn(text: "*Sztab:*\n\n#{people}")
            end
          end

          stop!
        end
      end
    end
  end
end