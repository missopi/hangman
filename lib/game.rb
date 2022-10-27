# frozen_string_literal: true

require_relative 'rules'
require_relative 'colour'

# class for playing the game
class Game
  LETTERS = ('a'..'z').map { |char| char }

  def initialize
    @rules = Rules.new
    @lives = 9
    @incorrect_letters = []
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
    word = choose_word
    player_turn(word) while !won?(word) && !lost?
    puts "\n========================================================\n".yellow
    end_of_game(word)
  end

  def choose_letter
    print "\nChoose a letter or type 'save' to save your progress: "
    @user_input = gets.chomp
    return 'save' if @user_input.downcase == 'save'
  end

  def player_turn(word)
    puts "\n========================================================\n\n".yellow
    puts "You have #{@lives} incorrect guesses left."
    puts "Try to save the hanging man!!!\n\n"
    print_man_hanging
    puts display_word(word)
    puts "\nIncorrect letters: #{@incorrect_letters.join(' ').red}"
    puts "\nThe letters you can choose from are:\n\n"
    puts LETTERS.join(' - ')
    choose_letter
    check_guess(word, @user_input) if letter_valid?
    puts 'Invalid entry'.red unless letter_valid? || @user_input == 'save'
  end

  def letter_valid?
    return true if @user_input.length == 1 && @user_input.between?('a', 'z')
  end

  def display_word(word)
    word.split('').map do |char|
      if LETTERS.include?(char.downcase)
        ' _ '
      else
        " #{char.downcase} "
      end
    end
        .join('')
  end

  def check_guess(word, char)
    unless word.downcase.include?(char.downcase) && LETTERS.include?(char.downcase)
      @lives -= 1
      unless @incorrect_letters.include?(char.downcase) || word.downcase.include?(char.downcase)
        @incorrect_letters << char.downcase
      end
    end
    LETTERS.delete(char.downcase)
  end

  def end_of_game(word)
    if won?(word)
      puts "\nCongratulations! you saved the hanging man!\n\n"
      puts "The hidden word was '#{word}'.\n\n"
      exit
    else
      print_hanged_man
      puts "\nBetter luck next time. \n\n"
      puts "The hidden word was '#{word}'.\n\n"
    end
  end

  def print_hanged_man
    puts " --------  \n |/     | \n |      O \n |     /|\\ \n |     / \\ \n ----\n\n"
  end

  def won?(word)
    display_word(word).split(' ').join('').downcase == word.downcase
  end

  def lost?
    @lives.zero?
  end

  def over?
    won?(word) || lost?
  end

  def print_man_hanging
    case @lives
    when 9
      puts "\n\n\n\n\n\n"
    when 8
      puts " --------  \n | \n | \n | \n | \n ----\n\n"
    when 7
      puts " --------  \n | \n |      O \n | \n | \n ----\n\n"
    when 6
      puts " --------  \n | \n |      O \n |      | \n | \n ----\n\n"
    when 5
      puts " --------  \n | \n |      O \n |      |\\ \n | \n ----\n\n"
    when 4
      puts " --------  \n | \n |      O \n |     /|\\ \n | \n ----\n\n"
    when 3
      puts " --------  \n | \n |      O \n |     /|\\ \n |       \\ \n ----\n\n"
    when 2
      puts " --------  \n | \n |      O \n |     /|\\ \n |     / \\ \n ----\n\n"
    when 1
      puts " --------  \n |/ \n |      O \n |     /|\\ \n |     / \\ \n ----\n\n"
    end
  end
end
