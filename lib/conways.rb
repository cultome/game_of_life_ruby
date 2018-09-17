require "conways/version"

module Conways
  attr_reader :state
  attr_reader :width
  attr_reader :height

  class Game
    def initialize(initial_state)
      @state = initial_state
      @width = initial_state.first.size-1
      @height = initial_state.size-1
    end

    def next_gen
      new_state = clone_state

      each_cell do |x,y|
        new_state[y][x] = will_live?(x,y) ? 1: 0
      end
      @state = new_state
    end

    def will_live?(x,y)
      neighbors = [
        top_left?(x,y),
        top?(x,y),
        top_right?(x,y),
        right?(x,y),
        left?(x,y),
        bottom_left?(x,y),
        bottom?(x,y),
        bottom_right?(x,y),
      ].select{|live| live }.size

      if live?(x,y)
        neighbors == 2 || neighbors == 3
      else
        neighbors == 3
      end
    end

    def each_cell
      0.upto(width) do |x|
        0.upto(height) do |y|
          yield(x,y)
        end
      end
    end

    def print
      state.each do |row|
        puts row.join("")
      end
    end

    private

    def clone_state
      state.reduce([]) do |acc,row|
        acc << row.clone
        acc
      end
    end

    def top_left?(x,y)
      x > 0 && y > 0 && state[y-1][x-1] == 1
    end

    def top?(x,y)
      y > 0 && state[y-1][x] == 1
    end

    def top_right?(x,y)
      x < width && y > 0 && state[y-1][x+1] == 1
    end

    def right?(x,y)
      x > 0 && state[y][x-1] == 1
    end

    def live?(x,y)
      state[y][x] == 1
    end

    def left?(x,y)
      x < width && state[y][x+1] == 1
    end

    def bottom_left?(x,y)
      x > 0 && y < height && state[y+1][x+1] == 1
    end

    def bottom?(x,y)
      y < height && state[y+1][x] == 1
    end

    def bottom_right?(x,y)
      x < width && y < height && state[y+1][x+1] == 1
    end
  end
end
