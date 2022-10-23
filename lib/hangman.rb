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

Man.new
  
class Word
  def initialize
  end
    
  def display_blank_word(word)
  end
    
  def update_word(hanging_man)
  end
end
  
class Game
end