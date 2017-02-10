#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: Waibin Wang et Riviere Marius
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'
require_relative 'CellView.rb'
require_relative '../class/board_class.rb'
require_relative '../class/cell_class.rb'
require_relative '../class/solver_class.rb'

##class héritant de Gtk::Frame
#permet d'être ajoutée dans une fenêtre
class GridPanel < Gtk::Frame
	##Variables	
	@board #grille de sudoku de board_class.rb
	@boardBoxView #c'est une gtk::Table qui contient les boxs de la grille de sudoku
	@boxView#tableau de boxs de la grille
	@cellsView#comporte un tableau de CellView.rb
	##constructeur
	#@param : un board de board_class.rb
	def initialize(board)
		super()		
		@board=board
		@boardBoxView=Gtk::Table.new(3,3,true)

		@solver = Solver.creer @board
		@solver.solveLogic
		@solver.solve

		@boxView=Array.new(3){Array.new(3)}

		0.upto(2){|y|
			0.upto(2){|x|
				@boxView[x][y]=Gtk::Table.new(3,3,true)
				
				0.upto(2){|i|
					0.upto(2){|j|
						cell=CellView.new(@board.cellAt(x*3+i,y*3+j))
						@boxView[x][y].attach(cell,i,i+1,j,j+1)
					}
				}
				@boardBoxView.attach(Gtk::Frame.new().add(@boxView[x][y]),x,x+1,y,y+1,nil,nil,3,3)
							
			}
		}
		add(@boardBoxView)
	end


end




