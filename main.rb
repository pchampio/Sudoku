#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: *
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#
#:nodoc:
Dir[File.dirname(__FILE__) + '/class/*.rb'].each {|file| require file }

# x = Generator.new
# x.randomize
# print x.board
# # reduce
# # :easy, :medium, :hard, :extreme
# Generator.reduce(x.board,:extreme)
# print "\n", x.board, "\n Length ", x.board.usedCells.length, "\n"
# usedCells = x.board.usedCells
# # Tris les cases par leurs fréquence d'apparition dans la planche
# # Permet d'homogénéiser la planche (ce qui la rend plus dure)
# usedCells.sort_by!{|v| -x.board.sameCellsValue(v).length}

# usedCells.each do |usedcell|
  # print "#{x.board.sameCellsValue(usedcell).length} #{usedcell}\n"
# end

# # solver
# s = Solver.creer(x.board)
# s.solveLogic
# # s.solve() # false pour disable l'anim
# puts
# # print s.board.complete?, "\n"
# print s


# exit


planche_base = "
  _ _ 1   _ _ _   3 _ _
  _ _ 6   9 _ _   2 _ 8
  _ _ _   7 5 _   _ _ _

  9 _ _   _ _ _   _ _ _
  _ _ _   _ _ 2   7 _ 1
  2 3 _   _ _ _   8 9 5

  _ _ _   8 6 7   _ _ _
  4 _ _   _ 1 _   _ 2 _
  6 7 5   _ _ _   _ _ _
".tr("_", "0")
test = Board.creer(planche_base.delete("\s|\n")
  .split("").reverse.map(&:to_i))

s = Solver.creer(test)
s.solveLogic
# s.solve() # false pour disable l'anim
print s
