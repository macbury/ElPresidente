module Elpresidente
  module Skills
    module Announcements
      class SayMorningHello < CronSkill
        HELLO = [
          'Привет', 'Доброе утро!', 'Witojcie', 'Witajce', 'Heeejka'
        ]

        def execute
          return unless cron_match?('30 8 * * 1,2,3,4,5')

          say!(HELLO.sample)
        end

        private

        def channel_name
          'notifications'
        end
      end
    end
  end
end