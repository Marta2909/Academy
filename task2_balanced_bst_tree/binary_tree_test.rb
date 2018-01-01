# tutaj będą (?) testy
require 'minitest/autorun'
require_relative 'binary_tree'

class BinaryTreeTest < Minitest::Test

#utworzenie drzewa z pustej tablicy (wynik: obiekt z value=nil, left=nil, right=nil)
  def test_create_bst_tree_from_empty_array
    tree = BinaryTree.create([])
    assert tree.value == ''
    assert tree.left == nil
    assert tree.right == nil
  end

#utworzenie drzewa z tablicy jednoelementowej (wynik: obiekt z value=wartość, left=nil, right=nil)
  def test_create_bst_tree_from_one_element_array
    tree = BinaryTree.create([5])
    assert tree.value == '5'
    assert tree.left == nil
    assert tree.right == nil
  end

# #bardziej skomplikowany przypadek, na przykład podany w pliku example.rb
  def test_create_bst_tree_from_array
    tree = BinaryTree.create([3, 1, 2, 9, 7, 8, 6])
    assert tree.value == '6'
    assert tree.left.class == BinaryTree
    assert tree.right.class == BinaryTree
    assert tree.left.value == '2'
    assert tree.right.value == '8'
  end
end
