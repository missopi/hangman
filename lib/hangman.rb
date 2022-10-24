# frozen_string_literal: true

require_relative 'rules.rb'

# class for assigning the player
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

# class for playing the game
class Game
  attr_reader :word

  LETTERS = ('a'..'z').map { |char| char }

  def initialize
    @rules = Rules.new
    @player = Player.new
  end

  def move
    @incorrect_guesses = 0
    player_turn while @incorrect_guesses < 9
  end
 
  def display_word(word)
    word.split('').map do |char|
      if LETTERS.include?(char.downcase)
        ' _ '
      else
        ' ' + char.downcase + ' '
      end
    end
    .join("")
  end

  def check_guess(word, char)
    if word.downcase.include?(char.downcase) &&
      LETTERS.include?(char.downcase)
      LETTERS.delete(char.downcase)
    else
      LETTERS.delete(char.downcase)
      @incorrect_guesses += 1
    end
    puts display_word(word)
  end


end

Game.new.move
