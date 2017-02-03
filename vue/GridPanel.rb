require 'gtk3'
require_relative 'CellView.rb'
require_relative '../class/board_class.rb'
require_relative '../class/cell_class.rb'

class GridPanel

	def initialize(board)
		@board=board
		@boardView=Gtk::Table.new(3,3,true)

		@boxView=Array.new(3){Array.new(3)}

		0.upto(2){|y|
			0.upto(2){|x|
				@boxView[x][y]=Gtk::Table.new(3,3,true)
				
				0.upto(2){|i|
					0.upto(2){|j|
						cell=CellView.new(@board.cellAt(x*3+i,y*3+j))
						@boxView[x][y].attach(cell.button,i,i+1,j,j+1)
					}
				}
				@boardView.attach(@boxView[x][y],x,x+1,y,y+1,nil,nil,3,3)
				@boxView[x][y].show
			}
		}
		
		@boardView.show
	end

	def boardView()
		return @boardView
	end

end




