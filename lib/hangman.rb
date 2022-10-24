# frozen_string_literal: true

# class for assigning the players
class Player
  attr_reader :name
  
  def initialize
    puts 'Please enter your name.'
    @name = gets.chomp.capitalize!
    puts ' '
  end
end

# class for designing and displaying the hanging man
class Man
  attr_reader :man
  
  def initialize
    @man = Array.new(9,' ')
    @hanged_man = ['|', '-', 'O', '|', '/', '\\', '/', '\\', '|']
  end
  
  def update_man(index, hanged_man)
    man[index] = hanged_man[index]
    display_man(man)
  end
  
  def display_man(man)
    puts ' '
    puts " #{man[1]}#{man[1]}#{man[1]}#{man[1]}#{man[1]}#{man[1]}#{man[1]}#{man[1]}  "
    puts " #{man[0]}      #{man[8]}  "
    puts " #{man[0]}      #{man[2]}  "
    puts " #{man[0]}     #{man[4]}#{man[3]}#{man[5]} "
    puts " #{man[0]}     #{man[6]} #{man[7]} "
    puts ' '
  end
end

class Word
  attr_reader :word,

  def initialize
    @word = 'hippopotamus'
    @available_letters = ("a".."z").map { |char| char }
  end

  def display_word(word)
    word.split("").map do |char|
      if @available_letters.include?(char.downcase)
        " _ "
      else
        " " + char.downcase + " "
      end
    end
    .join("")
  end
end

class Rules
    def initialize
        puts "\n============= Hangman =============\n\n"
        puts "You will have 9 turns to guess the hidden word.\n\nEach wrong letter gets you a step closer to being hanged.\n\n"
        puts ' --------  '  
        puts ' |      |  '
        puts ' |      O  '
        puts ' |     /|\ '
        puts ' |     / \ '
        puts '---- '
        puts "\nThe hidden word will be shown as a row of dashes representing each letter of the word.\n"
        puts "\n_ _ _ _ _ _ _\n\nEach correct letter will be displayed in the word.\n"
        puts "\n_ a _ _ _ a _\n\n========== End of Rules ==========\n\n"
    end
end
  
class Game
  def initialize
    @rules = Rules.new
    @player = Player.new
  end

  def move
    over?
    @man = Man.new
    @word = Word.new
    Word.display_word(word)
    @incorrect_guesses = 0
    player_turn while @incorrect_guesses < 9
  end

  def player_turn
    if @word.includes?(letter)
      update_word(index, letter)
    else
      @incorrect_guesses += 1
    end
  end
end

# track letters_guessed = []
# track correct & incorrect guesses
# win/lose?
# current word
# current state of hanged man