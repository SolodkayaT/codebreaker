require_relative 'console'
module Codebreaker
  class Game
    attr_accessor :game_code, :chances
    CHANCES_COUNT = 10

    def initialize
      @game_code = generate
      @chances = Codebreaker::Game::CHANCES_COUNT
    end

    def generate
      (1..4).map { rand(1..6) }.join
    end

    def checking_results(guess) 
      @chances -=1
      return "++++" if guess == @game_code
      result = ''
      code = @game_code.chars
      answer = guess.chars
      code.map.with_index do |item, index|
        next unless answer[index] == item
        result <<'+'
        answer[index] = code[index] = nil
      end
      code.compact!
      answer.compact!
      code.each do |item|
        next unless answer.include?(item)
        answer[answer.index(item)] = nil
        result << '-'
      end
      result
    end
    end
  end