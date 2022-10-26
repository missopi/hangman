class Rules
    def initialize
        puts "\n======================= Hangman ========================\n\n"
        puts "You will have 9 turns to guess the hidden word.\n\nEach wrong letter gets you a step closer to being hanged.\n\n"
        puts ' --------  '  
        puts ' |      |  '
        puts ' |      O  '
        puts ' |     /|\ '
        puts ' |     / \ '
        puts '---- '
        puts "\nThe hidden word will be shown as a row of dashes representing each letter of the word.\n"
        puts "\n_ _ _ _ _ _ _\n\nEach correct letter will be displayed in the word.\n"
        puts "\n_ a _ _ _ a _\n\n==================== End of Rules ======================\n\n"
    end
end