# frozen_string_literal: true

# class for assigning the players
class Player
  attr_reader :name
  
  def initialize
    puts 'Please enter your name.'
    @name = gets.chomp.capitalize!
  end
end

