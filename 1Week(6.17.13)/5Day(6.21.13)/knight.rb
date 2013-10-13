class KnightPathFinder

	require './tree_node.rb'
	attr_accessor :root

	def initialize(pos = [0,0])
		@root = TreeNode.new(pos)
		build_move_tree
	end

	def find_path(stop_pos)
		end_node = @root.bfs(stop_pos)
		build_path(end_node)
	end	

	#private

	def build_move_tree
		visited = [@root.value]
		nodes = [@root]

		while !nodes.empty?
			current = nodes.shift
			moves = find_new_move_positions(current.value)

			moves.each do |move|
				next if visited.include?(move)
				nodes << current.add_child(TreeNode.new(move))
				visited << move
			end
			nodes.each {|n| p n.value}
		end
		@root
	end

	def find_new_move_positions(pos)
		moves = []
		offset = [[-2, -1], [-2,  1], 
				[-1, -2], [-1,  2], 
				[ 1, -2], [ 1,  2], 
				[ 2, -1], [ 2,  1]]

		offset.each do |(x, y)|
			new_pos = [pos[0] + x, pos[1] + y]
			moves << new_pos unless new_pos.any? { |e| (e > 7 || e < 0)}
		end
		moves
	end

	def build_path(node)
		p node
		path = []
		current_node = node

		until current_node.parent.nil?
			current_node.value
			current_node = current_node.parent
		end
		path
	end

end
=begin
class TreeNode

	attr_accessor :parent, :value
	attr_reader :children

	def initialize(value = nil)
		@parent = nil
		@children = []
		@value = value
	end

	def add_child(val)
		child = TreeNode.new(val)
		@children << child
		child.parent = self
	end

	def dfs(val) # depth first search
		return self if @value == val
		@children.each do |child| 
			next if child.nil?
			v = child.dfs(val)
			return v if !v.nil?
		end

		nil
	end

	def bfs(val) # bredth first search
		nodes = [self]
		while nodes.count > 0
			parent = nodes.shift
			return parent if parent.value == val
			parent.children.each {|child| nodes << child if !child.nil?}
		end
	end

=end
