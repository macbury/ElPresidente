module Elpresidente
  module Skills
    module Badges
      class Show < Skill
        use ::Badges::FetchBoard, as: :fetch_board

        def execute
          return unless mentioned? || personal?
          return unless match?(/chwdp$/i)

          typing!
          react!('+1')

          task.async do
            reply!('Chwała wszystkim dobrym programistom') do |block|
              block.section do |section|
                section.mrkdwn(text: 'Chwała wszystkim dobrym programistom:')
              end

              block.section do |section|
                text = fetch_board.map do |user_id, info|
                  "- <@#{user_id}> - *#{info[:range]}* z #{info[:points]} punktami"
                end.join("\n")
                section.mrkdwn(text: text)
              end
            end
          end

          stop!
        end
      end
    end
  end
end