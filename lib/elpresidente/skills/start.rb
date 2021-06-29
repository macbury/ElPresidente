module Elpresidente
  module Skills
    # Main skill that tries to find skill to execute
    class Start < Base
      ERROR_RESPONSES = [
        'Ojć',
        'Nosz kurdefele',
        'Co się janie pawle odpernicza',
        'No i ch*j, no i cześć',
        'fuuuuuuuuuuuuck',
        'I co panie zrobisz, nic panie nie zrobisz...',
        'Jaaaaaaaa',
        'Shittt',
        'Na odyna!',
        'Zdaża się najlepszym',
        'Coś zjebałeś',
        'Na posejdona dobrze że nie jest to js'
      ].freeze

      def execute
        sequence [
          Orwell,
          Badges::AwardAMedal,
          Badges::Show,
          Reactions::Apply,
          Reactions::Manage,
          Admin::Start,
          Meme::ShowTvp,
          Meme::Suchar,
          Gentlemen::Help,
          Gentlemen::Time,
          Gentlemen::Offend,
          Gentlemen::AskWhatYouWant
        ]
      rescue => e
        Async.logger.error "[#{e.class}] #{e} Failed to process #{data}"
        Async.logger.error e.backtrace.join("\n")

        react!('boom')
        reply = ERROR_RESPONSES.sample

        reply!(reply) do |block|
          block.section do |section|
            section.mrkdwn(text: "*#{reply}:*\n```#{e.class} #{e}```\n```#{e.backtrace.join("\n")}```")
          end
        end
      end
    end
  end
end