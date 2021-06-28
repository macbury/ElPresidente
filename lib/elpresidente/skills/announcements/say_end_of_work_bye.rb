module Elpresidente
  module Skills
    module Announcements
      class SayEndOfWorkBye < CronSkill
        BYE = [
          'Bye', 'Narazie', 'Bye bye', 'Sayonara', 'Kamikadze', 'Yolo!'
        ]
        
        def execute
          return unless cron_match?('30 16 * * 1,2,3,4,5')

          say!(BYE.sample)
        end

        private

        def channel_name
          'notifications'
        end
      end
    end
  end
end