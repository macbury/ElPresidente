module Elpresidente
  module Skills
    # Main skill that tries to find skill to execute for cron task
    class Cron < Base
      def execute
        sequence [
          Announcements::GoodStartOfDay,
          Announcements::SayEndOfWorkBye,
          Announcements::SayMorningHello
        ]
      end
    end
  end
end