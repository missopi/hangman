# frozen_string_literal: true

require_relative 'colour'

# class for writing rules at the beginning of the game
class Rules
  def initialize
    rules_start
    rules_end
  end

  def rules_start
    puts "\n======================= Hangman ========================\n\n".yellow
    puts "You will have 9 turns to guess the hidden word.\n\nEach wrong letter gets you a step closer to being hanged.\n\n"
    puts ' --------  '
    puts ' |/     |  '
    puts ' |      O  '
    puts ' |     /|\ '
    puts ' |     / \ '
    puts ' ----'
  end

  def rules_end
    puts "\nThe hidden word will be shown as a row of dashes representing each letter of the word.\n"
    puts "\n_  _  _  _  _  _  _\n\n"
    puts "Each correct letter will be displayed in the word.\n"
    puts "\n_  a  _  _  _  a  _\n\n"
    puts "Incorrect guesses will be listed below the missing word.\n\n"
  end
end
