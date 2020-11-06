require 'pry'
require "spec_helper"
require 'stringio'

module God

  describe Game do

    before do
      nop = 3
      poa = 10
      @game = Game.new(nop, poa)
      @game.instance_variable_set(:@current_player, @game.send(:set_initial_player))
    end

    context "#initialize" do

      it "initializes the game players with total number of provided players" do
        expect(@game.players.count.eql?(@game.nop)).to be true
      end

      it "initializes the game players attr with order rank and score" do
        expect(@game.players.last.order.nil?).to be false
        expect(@game.players.last.rank.nil?).to be false
        expect(@game.players.last.score.nil?).to be false
      end
    end

    context "#set players" do

      it "sets players as per provided input" do
        expect(@game.players.count).to eq(@game.nop)
        expect(@game.players).to be_a Array
        expect(@game.players.last).to be_a God::Player
      end

      it "checks the name of the players" do
        expect(@game.players[0].name.include?("player-")).to be true
        expect(@game.players[1].name.include?("player-")).to be true
        expect(@game.players[2].name.include?("player-")).to be true
      end

    end

    context "#poa (points of accumulate)" do
      
      it "check poa" do
        expect(@game.poa).to eq(10)
      end
    end

    context "#test player has got 6" do

      it "should get 1 more chance to play if not finshed" do
        expect(@game.set_current_player(6)).to eq(@game.current_player)
      end

      it "should not get chance to play if finshed and it will return next player" do
        old_current_player = @game.current_player
        old_current_player.update_score!(12)
        old_current_player.update_status('finished')
        expect(@game.set_current_player(6)).to_not eq(old_current_player)
      end
    end

    context "#test player has not got 6" do

      it "should return next player" do
        old_current_player = @game.current_player
        expect(@game.set_current_player(4)).to_not eq(old_current_player)
      end
    end

    context "#test player has got two consecutive 1's" do

      it "should wait(skip) for 1 round to play" do
        old_current_player = @game.current_player
        @game.update_score(1)
        @game.update_score(1)
        expect(@game.skip_round?).to be true
        expect(@game.set_current_player(1)).to_not eq(old_current_player)
      end

      it "should not wait(skip) for 1 round to play" do
        old_current_player = @game.current_player
        @game.update_score(1)
        @game.update_score(2)
        expect(@game.skip_round?).to be false
        expect(@game.set_current_player(1)).to_not eq(old_current_player)
      end
    end

  end
end
