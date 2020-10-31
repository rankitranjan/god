module God
  class Player
    attr_accessor :name, :order, :score, :rank, :status, :skip_turn

    def initialize(name, order)
      @name = name
      @order = order
      @rank = 0
      @score = 0
    end

    def has_won?(poa)
      @score.to_i >= poa.to_i
    end
  end
end
