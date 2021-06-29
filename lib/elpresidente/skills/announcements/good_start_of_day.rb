module Elpresidente
  module Skills
    module Announcements
      class GoodStartOfDay < CronSkill
        use ::Meme::RandomTvp, as: :generate_random_tvp_image_url
        use ::Meme::Suchar, as: :random_suchar
        use ::Meme::Slang, as: :random_slang
        use ::Fortunes::Load, as: :random_fortune
        use TodayHoliday, as: :today_holidays

        def execute
          return unless cron_match?('10 9 * * 1,2,3,4,5')

          info 'Running Start of day Announcements'

          tvp_image_url = generate_random_tvp_image_url(internet: internet)
          suchar = random_suchar(internet: internet)
          slang = random_slang(internet: internet)
          fortune = random_fortune.first # Brutal but effective
          holidays = today_holidays

          say!('Witajcie, tu Wasz El Presidente!') do |blocks|
            blocks.section do |section|
              section.mrkdwn text: <<~SLANG
                *Dzisiaj mamy święto:

                #{holidays.map { |text| "- #{text}" }.join("\n")}
              SLANG
            end

            blocks.section do |section|
              section.mrkdwn text: <<~SLANG
                *Z cyklu: ElPresidente łączy pokolenia, słówko na dzisiaj to: *

                `#{slang[:word]}`

                ```#{slang[:description]}```
              SLANG
            end

            blocks.divider

            blocks.section do |section|
              section.mrkdwn text: <<~MYSLI
                *Poranne przemówienie oraz złote myśli waszego wodza:*

                ```#{fortune}```
              MYSLI
            end

            blocks.divider

            blocks.section do |section|
              section.mrkdwn text: <<~MYSLI
                *Lekki suchar na gorące dni:*

                ```#{suchar.values.join("\n\n\n\n\n")}```
              MYSLI
            end

            blocks.divider

            blocks.image title: 'TVP/IP', url: tvp_image_url, alt_text: 'TVP/IP'
          end
          stop!
        end

        private

        def channel_name
          'random'
        end
      end
    end
  end
end