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

x = Generator.new
x.randomize
print x.board
# reduce
# :easy, :medium, :hard, :extreme
Generator.reduce(x.board,:extreme)
print "\n", x.board
# solver
s = Solver.creer(x.board)
s.solve() # false pour disable l'anim
print s.board
exit


planche_base = "
  _ 9 1   _ _ _   5 _ _
  _ _ 8   _ _ _   9 7 _
  _ _ _   _ _ _   _ _ 2

  _ _ _   _ _ _   _ _ _
  1 5 _   _ _ 7   _ 4 _
  _ 8 _   _ _ 3   2 _ 9

  7 _ _   9 _ _   3 _ _
  _ _ _   6 4 _   _ _ _
  _ 4 2   _ _ _   _ 5 _

".tr("_", "0")
test = Board.creer(planche_base.delete("\s|\n")
  .split("").reverse.map(&:to_i))

s = Solver.creer(test)
s.solve() # false pour disable l'anim
print test
print s.board
