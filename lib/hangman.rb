# frozen_string_literal: true

# class for assigning the players
class Player
  attr_reader :name
  
  def initialize
    puts 'Please enter your name.'
    @name = gets.chomp.capitalize!
  end
end

# class for designing and displaying the hanging man
class Man
  attr_reader :man
  
  def initialize
    puts ' '
    puts ' --------  '
    puts ' |      |  '
    puts ' |      O  '
    puts ' |     /|\ '
    puts ' |     / \ '
    puts ' '
    @man = Array.new(8,' ')
    @hanged_man = ['|', '-', 'O', '|', '/', '\\', '/', '\\', '|']
  end
  
  def update_man(index, hanged_man)
    man[index] = hanged_man
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
  attr_reader :word

  def initialize
    @word = Array.new(12, '_')
  end
    
  def display_word(word)
    puts "#{word[0]} #{word[1]} #{word[2]} #{word[3]} #{word[4]} #{word[5]} #{word[6]} #{word[7]} #{word[8]} #{word[9]} #{word[10]} #{word[11]}"
  end
    
  def update_word(index, letter)
    word[index] = letter
    display_word(word)
  end
end
  
class Game
  def initialize
    puts ' '
    puts '========== Hangman =========='
    puts ' '
    @player = Player.new
  end

  def move
    over?
    @man = Man.new
    @word = Word.new
    @turn = 1
    player_turn while @turn < 9
  end

end