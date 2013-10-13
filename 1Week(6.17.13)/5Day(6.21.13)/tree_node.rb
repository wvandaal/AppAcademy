class BinaryTreeNode

	attr_accessor :value, :children, :parent

	def initialize(value = nil)
		@parent = nil
		@children = [nil, nil]
		@value = value
	end

	def left
		@children[0]
	end

	def left=(left_child)
		left_child.parent = self
		@children[0].parent = nil if !@children[0].nil?
		@children[0] = left_child
	end

	def right
		@children[1]
	end

	def right=(right_child)
		right_child.parent = self
		@children[1].parent = nil if !@children[1].nil?
		@children[1] = right_child
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
			parent.children.each {|child| nodes << child}
		end
	end
end

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
		child.parent = self
		@children << child
		child
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

end

=begin
	root = TreeNode.new("\t root")
	3.times {|i| root.add_child(i)}
	root.children.each { |child| 2.times {child.add_child(rand(5..20))} }

	puts root.value
	root.children.each { |child| print "  #{child.value}\t"}
	puts ""
	root.children.each do |child| 
		child.children.each do |grandchild|
			print "#{grandchild.value}  "
		end
	end
	puts "\n"



	root.bfs(1).children.each {|c| print "#{c.value}  "}
=end


