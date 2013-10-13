#!/usr/bin/env ruby

require 'yaml'

class Tile
  DELTAS = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
  ]

  attr_reader :pos, :explored, :flagged
  attr_accessor :bombed

  # You can't name an instance variable with a '?', but it's common to
  # give boolean accessors names ending with a '?'. We can use
  # `alias_method` as a directive to generate a "wrapper" method with
  # a new name:
  #     http://www.ruby-doc.org/core-1.9.3/Module.html#method-i-alias_method
  alias_method :bombed?, :bombed
  alias_method :flagged?, :flagged
  alias_method :explored?, :explored

  def initialize(board, pos)
    @board, @pos = board, pos
    @bombed, @flagged, @explored = false, false, false
  end

  def neighbors
    adjacent_coords = DELTAS.map do |(dx, dy)|
      [pos[0] + dx, pos[1] + dy]
    end.select do |(row, col)|
      # throw out out of bound coordinates
      [row, col].all? { |coord| (0...@board.grid_size).include?(coord) }
    end

    adjacent_coords.map { |pos| @board.tile_at(pos) }
  end

  def adjacent_bomb_count
    neighbors.map { |tile| tile.bombed? ? 1 : 0 }.inject(0, :+)
  end

  def toggle_flag
    # ignore flagging of explored squares
    return if @explored

    @flagged = !@flagged
  end

  def flagged_correctly?
    bombed? && flagged?
  end

  def explore
    # don't explore a location user thinks is bombed.
    return self if flagged?

    # don't revisit previously explored tiles
    return self if explored?

    @explored = true
    if (not bombed?) && adjacent_bomb_count == 0
      neighbors.each { |adj_tile| adj_tile.explore }
    end

    self
  end

  def inspect
    # don't show me the whole board when inspecting a Tile
    { :pos => pos,
      :bombed => bombed,
      :flagged => flagged,
      :explored => explored }.inspect
  end

  def render
    if flagged?
      "F"
    elsif explored?
      adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
    else
      "*"
    end
  end

  def reveal
    if flagged
      # mark true and false flags
      bombed? ? "F" : "f"
    elsif bombed?
      # display a hit bomb as an X
      explored? ? "X" : "B"
    else
      adjacent_bomb_count == 0 ? "_" : adjacent_bomb_count.to_s
    end
  end
end

class Board
  attr_reader :grid_size, :num_bombs

  def initialize(grid_size, num_bombs)
    @grid_size, @num_bombs = grid_size, num_bombs

    @grid = generate_board
    plant_bombs
  end

  def tile_at(pos)
    row, col = pos
    @grid[row][col]
  end

  def render(reveal = false)
    @grid.map do |row|
      row.map do |tile|
        reveal ? tile.reveal : tile.render
      end.join("")
    end.join("\n")
  end

  def reveal
    render(true)
  end

  def lost?
    @grid.any? do |row|
      row.any? { |tile| tile.bombed? && tile.explored? }
    end
  end

  def won?
    correct_flags = 0
    @grid.each do |row|
      row.each { |tile| correct_flags += 1 if tile.flagged_correctly? }
    end

    correct_flags == @num_bombs
  end

  private
  def generate_board
    Array.new(@grid_size) do |row|
      Array.new(@grid_size) { |col| Tile.new(self, [row, col]) }
    end
  end

  def plant_bombs
    total_bombs = 0
    while total_bombs < @num_bombs
      coord_range = (0...@grid_size).to_a
      rand_pos = Array.new(2) { (0...@grid_size).to_a.sample }

      tile = tile_at(rand_pos)
      next if tile.bombed?

      tile.bombed = true
      total_bombs += 1
    end
  end
end

class MinesweeperGame
  LAYOUTS = {
    :small => { :grid_size => 9, :num_bombs => 10 },
    :medium => { :grid_size => 16, :num_bombs => 40 },
    :large => { :grid_size => 32, :num_bombs => 160 } # whoa.
  }

  def initialize(size)
    layout = LAYOUTS[size]
    @board = Board.new(layout[:grid_size], layout[:num_bombs])
  end

  def play
    while true
      puts @board.render

      action, pos = get_move
      perform_move(action, pos)

      if @board.won?
        puts "You win!"
        return
      elsif @board.lost?
        puts "**Bomb hit!**"
        puts @board.reveal
        return
      end
    end
  end

  private
  def get_move
    action_type, row_s, col_s = gets.chomp.split(",")

    [action_type, [row_s.to_i, col_s.to_i]]
  end

  def perform_move(action_type, pos)
    tile = @board.tile_at(pos)
    case action_type
    when "f"
      tile.toggle_flag
    when "e"
      tile.explore
    when "s"
      # won't quit on save, just hit ctr-c to do that.
      save
    end
  end

  def save
    puts "Enter filename to save at:"
    filename = gets.chomp

    File.open(filename, "w") do |f|
      YAML.dump(self, f)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  # running as script

  case ARGV.count
  when 0
    MinesweeperGame.new(:small).play
  when 1
    # resume game, using first argument
    YAML.load_file(ARGV.shift).play
  end
end
