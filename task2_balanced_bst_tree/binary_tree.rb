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

    #tree = []

    sorted_array = array.sort # [1, 2, 3, 6, 7, 8, 9]

    average_index = (sorted_array.length/2).floor #3
    root_node = sorted_array[average_index] # 6
    value = root_node

    children = sorted_array.partition {|e| e < root_node} # [[1,2,3],[6,7,8,9]]

    left_child = children.first # [1,2,3]
    right_child = children.last[1..children.last.length-1] # [7,8,9]

    if left_child.length >= 1
      left = self.create(left_child)
    end

    if right_child.length >= 1
      right = self.create(right_child)
    end

    BinaryTree.new(left, right, root_node)
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
