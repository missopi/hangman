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

  LETTERS = ('a'..'z').map { |char| char }

  def initialize
    @rules = Rules.new
    @player = Player.new
  end

  def choose_word
    dictionary = File.readlines('google-10000-english-no-swears.txt')
    words = []
    dictionary.each do |line|
      line.chomp!
      words << line if line.length.between?(5, 12)
    end
    words.sample
  end

  def move
    @incorrect_guesses = 0
    @incorrect_letters = []
    player_turn while @incorrect_guesses < 9
  end

  def player_turn
    word = choose_word
    while !won?(word) && !lost?
      puts "\n===========================================================\n\n"
      puts "Try to save the hanging man!!!\n\n"
      puts display_word(word)
      puts ' '
      puts @incorrect_letters.join(' ')
      puts "\nThe letters you can choose from are below:\n\n"
      puts LETTERS.join(' - ')
      puts "\nChoose a letter:\n\n"
      letter = gets.chomp
      check_guess(word, letter)
    end

    puts "\n=============================================================\n"

    if won?(word)
      puts "\nCongratulations! you saved the hanging man!\n\n"
    else
      puts "\nBetter luck next time. This time you lost.\n"
      puts "The hidden word was '#{word}'.\n\n"
    end
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
      unless @incorrect_letters.include?(char.downcase) || word.downcase.include?(char.downcase)
        @incorrect_letters << char.downcase 
      end
    end
    puts display_word(word)
  end

  def won?(word)
    display_word(word).split(" ").join("").downcase == word.downcase
  end
  
  def lost?
    @incorrect_guesses == 9
  end

end

Game.new.move
