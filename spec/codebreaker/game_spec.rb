require_relative '../spec_helper'

module Codebreaker
  RSpec.describe Game do
    subject(:game) { Game.new }
    let(:game_code) { game.instance_variable_get(:@game_code) }

    context '#generate' do
      before do
        subject.generate
      end

      it 'save secret code' do
        expect(game_code).not_to be_empty
      end
      it 'save 4 numbers secret code' do
        expect(game_code.size).to eq(4)
      end
      it 'save secret code with numbers from 1 to 6' do
        expect(game_code).to match(/[1-6]+/)
      end
    end

    describe '#checking_results' do
      array_of_answers = [
        ['1234', '1234', '++++'],
        ['4444', '4444', '++++'],
        ['3331', '3332', '+++'],
        ['1312', '1212', '+++'],
        ['1234', '1266', '++'],
        ['1234', '6634', '++'],
        ['1234', '1654', '++'],
        ['1234', '4321', '----'],
        ['5432', '2541', '---'],
        ['1145', '6514', '---'],
        ['1244', '4156', '--'],
        ['1221', '2332', '--'],
        ['2244', '4526', '--'],
        ['5556', '1115', '-'],
        ['1234', '6653', '-'],
        ['3331', '1253', '--'],
        ['2345', '4542', '+--'],
        ['1243', '1234', '++--'],
        ['4111', '4444', '+'],
        ['1532', '5132', '++--'],
        ['3444', '4334', '+--'],
        ['1113', '2155', '+'],
        ['2245', '2155', '++'],
        ['4611', '1466', '---'],
        ['5451', '4445', '+-'],
        ['2122', '2211', '+--'],
        ['1134', '1234', '+++']

    ]

    it "game chances" do
      subject.checking_results('1234')
      expect(subject.instance_variable_get(:@chances)).to eq(9)
    end
    array_of_answers.each do |item|
      it "should return #{item[2]} if secret_code is #{item[0]} and player_code is #{item[1]}" do
        subject.instance_variable_set(:@game_code, item[0])
        expect(subject.checking_results(item[1])).to eq item[2]
      end
    end
  end
end
end
