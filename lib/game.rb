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

  attr_reader :word

  def initialize
    @letters = ('a'..'z').map { |char| char }
    @lives = 9
    @incorrect_letters = []
    @word = choose_word
    begin_game
  end

  def begin_game
    Rules.new
    puts "\n========================================================\n\n".yellow
    puts 'Would you like to 1) Start a new game.'
    puts '                  2) Load an existing game.'
    puts "\n\n========================================================\n\n".yellow
    user_choice = gets.chomp
    puts "invalid choice. Please input '1' or '2'." unless %w[1 2].include?(user_choice)
    user_choice == '1' ? move : load_game
  end

  def move
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

  def choose_letter
    print "\nChoose a letter or type 'save' to save your progress: "
    @user_input = gets.chomp
    return unless @user_input.downcase == 'save'

    save_game
    puts 'Your game has been saved.'
    puts 'Would you like to 1) quit the game'
    puts '                  2) carry on playing'
    user_choice = gets.chomp
    puts "invalid choice. Please input '1' or '2'." unless %w[1 2].include?(user_choice)
    user_choice == '1' ? begin_game : return
  end

  def player_turn(word)
    puts "\n========================================================\n\n".yellow
    puts "You have #{@lives} incorrect guesses left."
    puts "Try to save the hanging man!!!\n\n"
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

  def won?(word)
    display_word(word).split(' ').join('').downcase == word.downcase
  end

  def lost?
    @lives.zero?
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
    begin_game if new_game == 'y'
  end

  def save_game
    Dir.mkdir 'saved_games' unless Dir.exist? 'saved_games'
    puts 'What name would you like to save your file as?'
    filename = gets.chomp
    dump = YAML.dump(self)
    File.open(File.join(Dir.pwd, "/saved_games/#{filename}.yaml"), 'w') { |file| file.write dump }
  end

  def load_game
    filename = choose_game
    saved_file = File.open(File.join(Dir.pwd, "/saved_games/#{filename}.yaml"), 'r')
    YAML.safe_load(saved_file, permitted_classes: [Game])
  end

  def choose_game
    puts 'Enter which saved game would you like to load: '
    filenames = Dir.glob('saved_games/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
    puts filenames
    filename = gets.chomp
    return filename if filenames.include?(filename)

    puts "#{filename} does not exist.".red
  end
end

Game.new.move
