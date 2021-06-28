module Elpresidente
  module Skills
    # Watch people on #notifications channel
    class Orwell < Skill
      def execute
        return unless channel&.name == 'notifications'

        if match?(/(uszanowanie|siema|baj|czesc|cześć|bye|morning|hey|hej|hello|bye|nara)/i)
          react!('wave')
        elsif match?(/(afk|bck|bkm|back|jestem|bk)/)
          react!('eyes')
        end

        continue!
      end
    end
  end
end