require 'pry'

module GameHelper

  def set_current_player(dice=0)
    active_players = @players.reject { |player| player.finished? }
    if more_chance? && !@current_player.finished?
      puts "\nyou got one more chance because you matched our one of rules set 😎 😎"
      return @current_player
    end
    @current_player = if (!check_six(dice) || @current_player.finished?) || (@current_player && @current_player.skip_turn? && check_one(dice))
      is_last_active_player?(active_players) ? active_players[0] : select_next_player(active_players)
    else
      puts "\nyou got one more chance because you rolled a '6' 😎"
      @current_player
    end
  end

  def check_six(dice)
    dice == 6
  end

  def check_one(dice)
    dice == 1
  end

  def is_last_active_player?(active_players)
    @current_player == active_players[-1]
  end
  
  def select_next_player(active_players)
    active_players.select { |ap| ap.order ==  @current_player.order + 1}.first || active_players[0]
  end

  def skip_round?
    if @current_player.skip_turn?
      @current_player.update_skip_turn!(0)
      run_default_methods!
      return true
    elsif @current_player.finished?
      run_default_methods!
      return true
    end
    return false
  end
  
  # method for custom rules every 3 dice roll point equal to 10 will get 1 more chance to play.
  # first params for no. rounds and second is point to achieve.

  def more_chance?
    if @current_player && @current_player.interval_for_chance?(3, 15)
      return true
    end
    return false
  end

  def run_default_methods!
    print_players_score
    check_winner
    set_current_player    
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
      @current_player.update_status('finished')
      @current_player.rank = (@players.max { |p| p.rank }.rank + 1) if @current_player.rank == 0
      puts "\n 🔥 #{@current_player.name} has finished the game! and rank is: #{@current_player.rank} 🔥🔥🔥"
    end
  end
end
