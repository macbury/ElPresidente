module Badges
  class FetchBoard < ServiceWithWorksheet
    def call
      worksheet.rows[1..-1].each_with_object({}) do |(user_id, name, points, range, _codeshi), awards|
        awards[user_id] = {
          user_id: user_id,
          name: name,
          points: points,
          range: range
        }
      end
    end
  end
end