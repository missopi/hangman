# frozen_string_literal: true

require_relative 'rules'
require_relative 'colour'
require 'yaml'

# module for drawing hangman image
module Hangman
  def print_man
    case @lives
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

  def print_hanged_man
    puts ' --------  '
    puts ' |/     |  '
    puts ' |      O  '
    puts ' |     /|\ '
    puts ' |     / \ '
    puts '----'
    puts ' '
  end
end

# class for playing the game
class Game
  include Hangman

  def initialize
    @letters = ('a'..'z').map { |char| char }
    @rules = Rules.new
    @lives = 9
    @incorrect_letters = []
    @move = move
  end

  def move
    word = choose_word
    player_turn(word) while !won?(word) && !lost?
    puts "\n========================================================\n".yellow
    end_of_game(word)
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

  def start_turn_text
    puts "\n========================================================\n\n".yellow
    puts "You have #{@lives} incorrect guesses left."
    puts "Try to save the hanging man!!!\n\n"
  end

  def choose_letter
    print "\nChoose a letter or type 'save' to save your progress: "
    @user_input = gets.chomp
    return 'save' if @user_input.downcase == 'save'
  end

  def player_turn(word)
    start_turn_text
    print_man
    puts display_word(word)
    puts "\nIncorrect letters: #{@incorrect_letters.join(' ').red}"
    puts "\nThe letters you can choose from are:\n\n#{@letters.join(' - ')}"
    choose_letter
    check_guess(word, @user_input) if letter_valid?
    puts 'Invalid entry'.red unless letter_valid? || @user_input == 'save'
  end

  def letter_valid?
    return true if @user_input.length == 1 && @user_input.between?('a', 'z')
  end

  def display_word(word)
    word.split('').map do |char|
      if @letters.include?(char.downcase)
        ' _ '
      else
        " #{char.downcase} "
      end
    end
        .join('')
  end

  def check_guess(word, char)
    unless word.downcase.include?(char.downcase) && @letters.include?(char.downcase)
      @lives -= 1
      unless @incorrect_letters.include?(char.downcase) || word.downcase.include?(char.downcase)
        @incorrect_letters << char.downcase
      end
    end
    @letters.delete(char.downcase)
  end

  def end_of_game(word)
    if won?(word)
      puts "\nCongratulations! you saved the hanging man!\n\n"
    else
      print_hanged_man
      puts "\nBetter luck next time. \n\n"
    end
    puts "The hidden word was '#{word}'.\n\n"
    new_game
  end

  def new_game
    puts 'Do you want to play a new game? (y/n)'
    new_game = gets.chomp.downcase
    Game.new if new_game == 'y'
  end

  def won?(word)
    @display = display_word(word).split(' ').join('').downcase == word.downcase
  end

  def lost?
    @lives.zero?
  end

  def over?
    lost? || @display
  end
end

# class for saving yaml file of game
class SaveFile
  def initialize
    puts "\n======================= Hangman ========================\n\n".yellow
    puts 'Would you like to 1) Start a new game.'
    puts '                  2) Load an existing game.'
    puts "\n========================================================\n\n".yellow
    user_choice = gets.chomp
    puts "invalid choice. Please input '1' or '2'." unless %w[1 2].include?(user_choice)
    game = user_choice == '1' ? Game.new : load_game
    until game.over?
      if game.choose_letter == 'save'
        save_game(game)
        puts 'Your game has been saved.'
      end
    end
  end

  def save_game(current_game)
    Dir.mkdir 'saved' unless Dir.exist? 'saved'
    puts 'What name would you like to save your file as?'
    filename = gets.chomp
    dump = YAML.dump(current_game)
    File.open(File.join(Dir.pwd, "/saved/#{filename}.yaml"), 'w') { |file| file.write dump }
  end

  def load_game
    filename = choose_game
    saved = File.open(File.join(Dir.pwd, filename), 'r')
    loaded_game = YAML.safe_load(saved)
    saved.close
    loaded_game
  end

  def choose_game
    puts 'Enter which saved game would you like to load: '
    filenames = Dir.glob('saved/*').map { |file| file[(file.index.between?('/', '.'))] }
    puts filenames
    filename = gets.chomp
    puts "#{filename} does not exist.".red unless filenames.include?(filename)
  end
end

SaveFile.new
