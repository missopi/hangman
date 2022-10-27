# frozen_string_literal: true

require_relative 'game'
require_relative 'colour'
require 'YAML'

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
  filenames = Dir.glob('saved/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
  puts filenames
  filename = gets.chomp
  return load_file if games.include?(load_file)

  puts 'The game you requested does not exist.'.red unless filenames.include?(filename)
end

puts "\n======================= Hangman ========================\n\n".yellow
puts 'Would you like to 1) Start a new game.'
puts '                  2) Load an existing game.'
puts "\n========================================================\n\n".yellow
user_choice = gets.chomp
puts "invalid choice. Please input '1' or '2'." unless %w[1 2].include?(user_choice)

game = user_choice == '1' ? Game.new.move : load_game

until game.over?
  if game.choose_letter == 'save' 
    if save_game(game)
      puts 'Your game has been saved. Thanks for playing!'
      break
    end
  end
end
