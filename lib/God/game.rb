require 'pry'
require_relative "./game_helper.rb"

module God

  class Game
    include GameHelper

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

    def game_turn
      puts "\n>>>>>>>>>>> #{@current_player.name} its your turn  <<<<<<<<<<<<"
      puts "\n #{@current_player.name} round skipped" if @current_player.skip_turn?
      return if skip_round?
      points = dice_roll
      puts "\nPoints achieved: #{points} \n"
      update_score(points)
      print_players_score
      set_current_player(points)
      puts "\n"
      puts "\n______________________________________________________"
    end

    def set_players
      players = (1..@nop).map { |a| "player-#{a}"}.shuffle # ["player-5", "player-2", "player-8"}
      players_with_order = Hash[players.map.with_index { |player, order| [player, order] }] # {"player-2"=>0, "player-5"=>1}
      players = []
      players_with_order.each { |name, order| players << Player.new(name, order) }
      players
    end

    def dice_roll
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

    def starting_message
      display_players
      puts "\n>>>>>>>>>>>  #{@current_player.name} will start the game. <<<<<<<<<<<<"
    end

    def display_players
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
      @current_player.update_score!(@current_player.score + points)
      @current_player.update_status('in_play')
      @current_player.update_round_and_point(points)
      check_winner
      skip_turn(points)
    end

    def skip_turn(points)
      if points.to_i == 1
        @current_player.update_skip_turn!(@current_player.skip_turn + 1)
      else
        @current_player.update_skip_turn!(0)
      end
      if @current_player.skip_turn? && !@current_player.has_won?(@poa)
        puts "\n ⚠️  ⚠️   #{current_player.name} have to skip for next round ⚠️   ⚠️"
      end
    end
  end
end
