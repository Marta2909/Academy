require_relative 'binary_tree.rb'
b = BinaryTree.create([3, 1, 2, 9, 7, 8, 6])
b.print_tree('tree.png')

c = BinaryTree.create([15,20,10,16,8,25,12])
c.print_tree('tree2.png')

d = BinaryTree.create([19,67,23,76,17,12,9,72,54,14,50])
d.print_tree('tree3.png')

e = BinaryTree.create([19,67,23,76,17,12,9,72,54,14,50,13,59])
e.print_tree('tree4.png')

f = BinaryTree.create([19,67,23,76,17,12,9,72,54,14,50,13,59,80])
f.print_tree('tree5.png')

g = BinaryTree.create([3, 1, 2, 5, 4, 9, 7, 8, 6])
g.print_tree('tree6.png')

h = BinaryTree.create([3, 1, 2, 5, 4, 9, 7, 8, 6, 10])
h.print_tree('tree7.png')
