module Elpresidente
  module Skills
    module Badges
      class AwardAMedal < Skill
        use ::Badges::AddAwards, as: :add_award

        RESPONSES = [
          'Dodano!',
          'OK, towarzyszu!',
          'Ya ya!',
          'Tak!'
        ]

        def execute
          return unless admin?
          return unless mentioned? || personal?
          return unless match?(/odznacz/i)

          typing!

          awards = message.scan(/<@(?<user_id>.+)>(?<raw_points>.+)$/i).each_with_object({}) do |(user_id, raw_points), hash|
            points = raw_points.scan(/:star:/).size
            hash[user_id] = {
              points: points,
              name: client.users[user_id].name,
              user_id: user_id
            } if points > 0
          end

          react!('wrench')

          task.async do
            board = add_award(awards)
            react!('ok')
            reply!('Aktualna lista:') do |block|
              block.section do |section|
                text = board.map do |user_id, info|
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