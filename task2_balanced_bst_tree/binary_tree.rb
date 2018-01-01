require 'bundler'

Bundler.require(:default)

class BinaryTree
  attr_reader :left
  attr_reader :right
  attr_reader :value

  def initialize(left, right, value)
    @left = left
    @right = right
    @value = value.to_s
  end

  def self.create(array)
    ### tutaj umiesc swoj kod

    if array.length == 0
      value = nil
      left = nil
      right = nil
      BinaryTree.new(left, right, value)
    else
      sorted_array = array.sort # [1, 2, 3, 6, 7, 8, 9]

      average_index = sorted_array.length/2 #3

      left_child = sorted_array.slice(0,average_index) # [1,2,3]
      right_child = sorted_array.slice(average_index+1,sorted_array.length) # [7,8,9]

      if left_child.length >= 1
        left = self.create(left_child)
      end

      if right_child.length >= 1
        right = self.create(right_child)
      end

      BinaryTree.new(left, right, sorted_array[average_index])
    end
  end

  def generate_graph_tree
    graph = GraphViz.new(:G, type: :graph)
    generate_graph_subtree(graph)
    graph
  end

  def generate_graph_subtree(graph)
    this_node = graph.add_nodes(value)
    if left
      left_node = left.generate_graph_subtree(graph)
      graph.add_edges(this_node, left_node)
    end
    if right
      right_node = right.generate_graph_subtree(graph)
      graph.add_edges(this_node, right_node)
    end
    this_node
  end

  def print_tree(file)
    generate_graph_tree.output(png: file)
  end
end
