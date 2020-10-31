module God

  class Game
    attr_reader :players, :current_player, :nop, :poa #(points of accumulate)

    def initialize(nop, poa)
      @nop = nop #no. of players
      @poa = poa #points of accumulate
      @players = set_players
    end

    def play
      starting_message
      while @players.select{ |player| player.status == "finished" }.count != @nop.to_i do
        game_turn
      end
      puts "\n Thanks for playing with us! Play again 😎😎😃 \n"
    end

    private

    def game_turn
      if @current_player.status == 'finished'
        print_players_score
        check_winner
        set_current_player
        return
      end
      puts "\n#{@current_player.name} its your turn"
      points = dice_roll.to_i
      puts "\nPoints achieved: #{points} \n"
      sleep 0.1
      update_score(points)
      print_players_score
      set_current_player(points)
      puts "\n"
      puts "\n______________________________________________________"
    end

    def set_players
      # sets the players and their orders
      players = (1..@nop).map { |a| "player-#{a}"}.shuffle # ["player-5", "player-2", "player-8"}
      players_with_order = Hash[players.map.with_index { |player, order| [player, order] }] # {"player-2"=>0, "player-5"=>1}
      players = []
      players_with_order.each { |name, order| players << Player.new(name, order) }
      players
    end

    # def current_player_index
    #   @players.index(@current_player)
    # end

    def set_current_player(dice=0)
      active_players = @players.reject { |player| player.status == "finished" }
      # set the current player based on the dice roll, if player gets 6 he moves again
      if dice != 6 || @current_player.status == "finished"
        if @current_player == active_players[-1]
          @current_player = active_players[0]
        else
          @current_player = active_players.select { |ap| ap.order ==  @current_player.order + 1}.first
          if @current_player.nil?
            @current_player = active_players[0]
          end
        end
      else
        puts "\nyou got one more chance because you rolled a '6' 😎"
        @current_player
      end
      if @current_player && @current_player.skip_turn.to_i >= 1 && dice == 1
        if @current_player == active_players[-1]
          @current_player = active_players[0]
        else
          @current_player = active_players.select { |ap| ap.order ==  @current_player.order + 1}.first
          if @current_player.nil?
            @current_player = active_players[0]
          end
        end        
      end
    end

    def dice_roll
      # random between 1 to 6
      loop do
        print "\nPress 'R'/r to roll the dice: "
        roll = gets.chomp
        if 'r' == roll.downcase
          return rand(1..6)
        else
          puts "#{@nop} is not a valid input"
        end
      end
    end

    def print_players_score
      puts "\nRank |   Name   |  Score | Status"
      puts '- - - - - - - - - - - - - - - - - -'
      @players.each do |player|
        puts "  #{player.rank}  | #{player.name} |   #{player.score} |   #{player.status}"
        puts '- - - - - - - - - - - - - - - - -'
      end
    end

    def check_winner
      #check for a winner and changes game status to finished and assign rank to it.
      if @current_player.has_won?(@poa)
        @current_player.status = 'finished'
        @current_player.rank = (@players.max { |p| p.rank }.rank + 1) if @current_player.rank == 0
        puts "\n 🔥 #{@current_player.name} has finished the game! and rank is: #{@current_player.rank} 🔥🔥🔥"
      end
    end

    def starting_message
      # Displays the players in game and the starting player
      display_players
      puts "\n>>>>>>>>>>>  #{@current_player.name} will start the game. <<<<<<<<<<<<"
    end

    def display_players
      # displays the players names and sets the starting player
      puts '--------------------'
      puts "Order | Player"
      puts '--------------------'
      @players.each do |p|
        puts "#{p.order+1}. #{p.name}"
      end
      @current_player = set_initial_player
    end

    def set_initial_player
      # starting player
      @players.first
    end

    def update_score(points)
      @current_player.score = @current_player.score.to_i + points.to_i
      @current_player.status = 'in_play'
      skip_turn(points)
      check_winner
    end

    def skip_turn(points)
      if points.to_i == 1
        @current_player.skip_turn = @current_player.skip_turn.to_i + 1
      else
        @current_player.skip_turn = 0
      end
    end
  end
end
