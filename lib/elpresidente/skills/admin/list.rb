module Elpresidente
  module Skills
    module Admin
      class List < Skill
        def execute
          return unless mentioned? || personal?
          return unless match?(/admin/i)

          reply!('Sztab:') do |block|
            block.section do |section|
              section.mrkdwn(text: "*Sztab:*\n\n" + blackboard.items('admins').map { |user_id| " - <@#{user_id}>" }.join("\n"))
            end
          end

          stop!
        end
      end
    end
  end
end