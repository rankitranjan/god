module God
  class Player
    attr_accessor :name, :order, :score, :rank, :status, :skip_turn, :round_and_point

    def initialize(name, order)
      @name = name
      @order = order
      @rank = 0
      @score = 0
      @round_and_point = []
      @skip_turn = 0
    end

    def has_won?(poa)
      @score.to_i >= poa.to_i
    end

    def finished?
      @status == 'finished'
    end

    def skip_turn?
      @skip_turn == 2
    end

    def update_skip_turn!(value)
      @skip_turn = value
    end

    def update_score!(value)
      @score = value
    end

    def update_status(value)
      @status = value
    end

    def interval_for_chance?(turn, point)
      @round_and_point.any? ? @round_and_point.last(turn).map { |rap| rap[:point] }.sum == point : false
    end

    def get_point
      @round_and_point.any? ? @round_and_point.map { |rap| rap[:point] }.sum : 0
    end

    def get_round
      @round_and_point.any? ? @round_and_point.last[:round] : nil
    end

    def update_round_and_point(point)
      round = get_round.to_i + 1
      @round_and_point << { round: round, point: point }
    end
  end
end
