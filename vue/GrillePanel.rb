require 'gtk3'
require_relative 'CellView.rb'
require_relative '../class/board_class.rb'
require_relative '../class/cell_class.rb'

class GrillePanel

	def initialize(board)
		@board=board
		@boardView=Gtk::Table.new(9,9,true)
		0.upto(8){|y|
			0.upto(8){|x|
				cell=CellView.new(@board.cellAt(x,y))
				@boardView.attach(cell.button,x,x+1,y,y+1)
			}
		}
		@boardView.show
	end

	def boardView()
		return @boardView
	end

end




