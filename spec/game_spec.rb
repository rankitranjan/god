require "spec_helper"
module God


  describe Game do

    before do
      nop = 3
      poa = 3
      @game = Game.new(nop, poa)
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
        expect(@game.poa).to eq(3)
      end
    end
  end
end
