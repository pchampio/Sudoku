require 'gtk3'
require_relative 'CellView.rb'
require_relative '../class/board_class.rb'
require_relative '../class/cell_class.rb'

class GrillePanel
	@board
	@boardView
	@rowView
	@columnView

	def initialize(board)
		@board=board
		@boardView=Gtk::Table.new(9,9,true)
		0.upto(8){|y|
			0.upto(8){|x|
				value=@board.cellAt(x,y).value()
				if(value!=0)
					@boardView.attach(CellView.new(@board.cellAt(x,y).value().to_s),x,x+1,y,y+1)
				else
					@boardView.attach(CellView.new(" "),x,x+1,y,y+1)
				end
			}
		}
		@boardView.show
	end

	def boardView()
		return @boardView
	end

end




