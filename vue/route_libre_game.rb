require 'gtk3'
require_relative '../class/board_class.rb'
require_relative '../class/cell_class.rb'
require_relative '../vue/component_board.rb'
require_relative '../vue/component_numpad.rb'
require_relative '../class/solver_class.rb'
require_relative '../vue/component_cell.rb'

class FreeModeGame < Gtk::Frame

	attr_accessor :grid, :numpad
	@celluleavant = nil
	def initialize(window,board)
		super()
		@board=board
		@window=window

		event1 = Gtk::Box.new(:vertical,2)
		event2 = Gtk::Box.new(:horizontal,2)
		@grid = BoardComponent.new(self,@board)
		label_title = Gtk::Label.new "Jeu Libre", :use_underline => true
		@numpad = NumpadComponent.create self


		event1.add(label_title)
		event1.add(event2)
		event2.add(@grid)
		event2.add(@numpad)

		@cellule=@board.cellAt(0,0)
		self.add(event1)
		show_all
	end

	def recupereCell(cellule)
		if(@celluleavant!=cellule && @celluleavant != nil)
			@celluleavant.set_color :default
		end
		@cellule=cellule
		@cellule.set_color :red

		@celluleavant = @cellule
	end

	def recupereNumber(number)
		@number=number
    	if(!@cellule.cell.freeze?)
      		@cellule.set_value @number
      		@cellule.set_color :default
    	else
      		print "La case est freeze\n"
    	end
	end
	def gommer()
		@number=0
    	if(!@cellule.cell.freeze?)
      		@cellule.set_value 0
    	else
      		print "La case est freeze\n"
    	end
	end
end
