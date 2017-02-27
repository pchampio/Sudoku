#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: Waibin Wang et Riviere Marius
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'
require_relative 'component_cell.rb'
require_relative '../class/board_class.rb'
require_relative '../class/cell_class.rb'
require_relative '../class/solver_class.rb'
require_relative '../vue/route_libre_game.rb'

##class héritant de Gtk::Frame
#permet d'être ajoutée dans une fenêtre
class BoardComponent < Gtk::Frame
	##Variables
	## @board #grille de sudoku de board_class.rb
	## @boardBoxView #c'est une gtk::Table qui contient les boxs de la grille de sudoku
	## @boxView#tableau de boxs de la grille
	attr_accessor :cellsView, :board#comporte un tableau de CellView.rb
	##constructeur
	#@param : un board de board_class.rb
	def initialize(panel,board)
		super()
		@board=board
		@panel=panel
		@boardBoxView=Gtk::Table.new(3,3,true)


		@boxView=Array.new(3){Array.new(3)}
		@cellsView=Array.new(9){Array.new(9)}

		0.upto(2){|y|
			0.upto(2){|x|
				@boxView[x][y]=Gtk::Table.new(3,3,true)

				0.upto(2){|i|
					0.upto(2){|j|
						cell=CellComponent.new(@board.cellAt(x*3+i,y*3+j))
						@boxView[x][y].attach(cell,i,i+1,j,j+1)
						@cellsView[x*3+i][y*3+j]=cell
						@cellsView[x*3+i][y*3+j].signal_connect("clicked"){
							@panel.recupereCell(@cellsView[x*3+i][y*3+j])

						}
					}
				}
				tmp = Gtk::Frame.new()
				tmp.add(@boxView[x][y])
				@boardBoxView.attach(tmp,x,x+1,y,y+1,nil,nil,3,3)

			}
		}
		add(@boardBoxView)
	end


end
