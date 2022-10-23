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
class HangingMan
  attr_reader :hanging_man
  
  def initialize
    puts ' - - - -  '
    puts ' |     O  '
    puts ' |    /|\ '
    puts ' |    / \ '
    puts ' --       '
    @hanging_man = ['\\', '/', '|', '\\', '/', 'O', '-', '-', '-', '-', '|', '|', '|', '-', '-' ]
  end
  
  def update_hanging_man(index, turn_taken)
    hanging_man[index] = turn_taken
    display_hanging_man(hanging_man)
  end
  
  def display_hanging_man(hanging_man)
  end
  
  end
  
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