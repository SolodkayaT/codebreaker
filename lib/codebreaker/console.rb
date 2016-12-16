require_relative 'game'
module Codebreaker
  
  class Console
    attr_accessor :game, :name, :hints, :game_status
    HINTS_COUNT = 1 

    def initialize
      @game = Codebreaker::Game.new
      @name = ''
      @hints = Codebreaker::Console::HINTS_COUNT
      @game_status = true
    end

    def hint
      return "You have no hints" if @hints==0
      @hints -=1
      @game.game_code.chars.sample
    end

    def win(guess)
      return "You win!" if guess == @game.game_code
      @game_status = false
      save(@name, 'win')
      puts "You win!"
    end

    def lose
      return "Game over" unless @game.chances == 0
      @game_status = false
      save(@name, 'lose')
      puts "Game over!"
    end

    def play_again
      puts "Do you want play again (Y)?"
      return unless gets.chomp == "y"
      @game = Game.new
      start
    end

    def save(name = 'No name', result = '')
      File.open('score.yml', 'a') do |file|
        file.puts "#{@name};#{@game.chances};#{result};#{Time.now}"
        puts "Your game score saved"
      end
      
    end

    def validation(guess)
      raise 'Secret code size should have 4 numbers' unless guess.size == 4
      raise 'Secret code should have numbers from 1 to 6' if (guess =~ /[1-6]{4}/).nil? 
    end

    def start
      puts "Enter your name:"
      @name = gets.chomp.capitalize
      puts "Enter your answer (4 numbers from 1 to 6)"
      puts "Enter 'H' - for hint,'Q' for exit"
      while @game_status do
        guess = gets.chomp.capitalize
        if guess == 'H'
          puts "One of the  number: #{hint}"
        elsif guess == 'Q'
          exit
        else
          validation(guess)
          puts "You have #{@game.chances} chance(s): "
          puts @game.checking_results(guess)
          win(guess)
          lose
          play_again unless @game_status
        end
      end
    Codebreaker::Console.new.start
    end
  end
end
