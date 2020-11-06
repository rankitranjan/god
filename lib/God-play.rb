require_relative "./God/version.rb"
require_relative "./God/player.rb"
require_relative "./God/game.rb"
require_relative "./God/game_helper.rb"

loop do
    print "Enter number of players: "
    nop = gets.chomp
    begin
        @nop = Integer(nop)
        if @nop >= 1
            break
        else
            puts "#{@nop} player is not allowed!, please put a positve number and try again."
        end
    rescue ArgumentError => _error
        puts "You didn't put numbers, please put numbers and try again."
    end
end

loop do
    print "Enter points of accumulate: "
    poa = gets.chomp
    begin
        @poa = Integer(poa)
        if @poa >= 1
            break
        else
            puts "#{@poa} is not allowed!, please put a positve value and try again."
        end
    rescue ArgumentError => _error
        puts "You didn't put integer, please put integer and try again."
    end
end

puts
puts "-------------------------------------------"
puts "Welcome. We have the following players:"
puts "-------------------------------------------"

God::Game.new(@nop, @poa).play
