module Elpresidente
  module Skills
    module Gentlemen
      class Offend < Skill
        use ::Meme::TwojaStara, as: :twoja_stara
        def execute
          return unless mentioned? || personal?

          case match?(/pociśnij <@(?<user_id>.+)>$/)
          in { user_id: }
            typing!

            say!("Hej <@#{user_id}>!")
            task.sleep 1
            say!('Wiesz co?')
            task.sleep 1
            say!(twoja_stara)

            stop!
          else
            skip!
          end
        end
      end
    end
  end
end