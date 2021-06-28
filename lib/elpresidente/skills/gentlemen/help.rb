module Elpresidente
  module Skills
    module Gentlemen
      class Help < Skill
        HELP = <<-HELP
*Komendy na kanałach gdzie jest wasz wódz*
musisz wezwać mnie w czacie i zaprosić do pokoju, wtedy wywołując me imie możesz podać jedną z komend:

np. `@elpresidente pomoc`

• `wiela na cykocu` - aktualny czas
• `pomoc` - łącze się z robotnikami
• `suchar` - losowy suchar z strony sucharr.pl
• `chwdp` - pokaż tablice z wynikami
• `tvp treść paska tvp` - generuj pasek tvp
• `odznacz @użytkownik :star: :star:` - podaruj użytkownikowi punkty. Każda gwiazdka to jeden punkt
• `reactions add @user :emoji:` - spraw aby bot dodawał emoji do każdego wpisy użytkownika
• `reactions remove @user :emoji:` - spraw aby bot nie dodawał emoji do każdego wpisy użytkownika
• `pociśnij @user` - niech ElPresidente obrazi @user

Kod źródłowy:
https://github.com/macbury/ElPresidente
HELP

        def execute
          return unless mentioned?
          return unless match?(/pomoc|help|about/)

          say!('Oto twa pomoc') do |blocks|
            blocks.section do |section|
              section.mrkdwn text: HELP
            end
          end
          stop!
        end
      end
    end
  end
end