require "spec_helper"

module God
  describe Player do

    context "#initialize" do

      it "raises an exception when initialized with ()" do
        expect { Player.new() }.to raise_error
      end

      it "does not raise an error when initialized with a valid input hash" do
        expect { Player.new("Player-x", 1) }.to_not raise_error
      end
    end

    context "#assign values" do

     it "set default values for rank and score" do
        player = Player.new("Player-x", 1)
        expect(player.rank).to eq(0)
        expect(player.score).to eq(0)
        expect(player.name).to eq("Player-x")
        expect(player.order).to eq(1)
      end
    end

    context "#players" do

      it "checks the number of players" do
        @game = Game.new(3, 4)
        expect(@game.players.count).to eq(3)
      end

      it "checks if player won/finished" do
        @game = Game.new(3, 4)
        player = @game.players.last
        player.score = 4
        # has_won?(poa)
        expect(player.has_won?(@game.poa)).to be true
      end

      it "checks if player not won/finished" do
        @game = Game.new(3, 4)
        player = @game.players.last
        player.score = 2
        # has_won?(poa)
        expect(player.has_won?(@game.poa)).to be false
      end
    end
  end
end
