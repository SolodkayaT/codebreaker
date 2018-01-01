require_relative'../spec_helper'

module Codebreaker
  RSpec.describe Console do
    subject(:console) {Console.new}
    let(:game) { console.instance_variable_get(:@game) }
    let(:game_code) { console.game.instance_variable_get(:@game_code) }

    context '#initialize' do
      it 'instance variables' do
        expect(console.game).to be_a_kind_of Codebreaker::Game
        expect(console.game_status).to eq(true)
        expect(console.hints).to eq(1)
      end
    end
    context "#hints" do
      it "reduce hints" do
        console.hint
        expect(console.hints).to eq(0)
      end
      it "game code include number of hint" do
        expect(console.game.instance_variable_get(:@game_code)).to include(console.hint)
      end
      it "player have no hints" do
        console.hint
        expect(console.hint).to eq("You have no hints")
      end
    end

    context '#win' do
      it 'return game win when guess = game code' do
        expect(subject.win(game.game_code)).to eq("You win!")
        end
      end

      context '#lose' do
        let(:chances) {subject.instance_variable_set(:@chances, 0)}
        it 'return game over when chanses = 0' do
          expect(subject.lose).to eq("Game over")
          end
        end

        context '#play_again' do
          it 'game start when player say Y' do
            allow(console).to receive(:gets).and_return("Y")
            expect { console.play_again }.to output(/again/).to_stdout
          end
        end

        context '#validation' do
          it 'guess must have 4 numbers' do
            expect { console.validation('12345') }.to raise_error RuntimeError
            expect { console.validation('123') }.to raise_error RuntimeError
          end
          it 'guess must to be a number' do
            expect { console.validation('1a45') }.to raise_error RuntimeError
          end
          it 'guess must contains number from 1 to 6' do
            expect { console.validation('1230') }.to raise_error RuntimeError
            expect { console.validation('1734') }.to raise_error RuntimeError
          end
        end

        context '#save' do
          it 'save game score to file' do
            console.save('score.yml')
            expect(File.exist?('score.yml')).to eq true
            expect{console.save}.to output(/game score saved/).to_stdout
          end
        end
      end
    end