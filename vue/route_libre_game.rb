require 'gtk3'
require 'yaml'
require_relative '../class/board_class.rb'
require_relative '../class/cell_class.rb'
require_relative '../vue/component_board.rb'
require_relative '../vue/component_numpad.rb'
require_relative '../class/solver_class.rb'
require_relative '../vue/component_cell.rb'
require_relative './serialisable.rb'


class FreeModeGame < Gtk::Frame

	attr_accessor :grid, :numpad
	@celluleavant = nil
	def initialize(window,board)


		


		super()
		@board=board
		@window=window
		@window.set_title "Sudoku (Jeu Libre)"
		@window.set_window_position Gtk::WindowPosition::CENTER
		@word=nil

		@event1 = Gtk::Box.new(:vertical,2)
		event2 = Gtk::Box.new(:horizontal,2)
		@grid = BoardComponent.new(self,@board)
		@numpad = NumpadComponent.create self


		@event1.add(event2)
		event2.add(@grid)
		event2.add(@numpad)

		@cellule=@board.cellAt(0,0)
		self.add(@event1)
		show_all
	end

	def recupereCell(cellule)
		if(@celluleavant!=cellule && @celluleavant != nil)
      @cellule.reset_color
		end
		@cellule=cellule

    @cellule.set_color #Gdk::Color.new(112, 117, 128)

		@celluleavant = @cellule
	end

	def recupereNumber(number)
		@number=number
    	if(!@cellule.cell.freeze?)
      		@cellule.set_value @number
      		#@cellule.set_color Gdk::Color.new(112, 117, 128)
      		if(@numpad.statut)
      			@cellule.set_value @number
      			color = Serialisable.getBackgroundColor()
      			#red = (color.red / 65535.0) * 255.0
  				#green = (color.green / 65535.0) * 255.0
 				#blue = (color.blue / 65535.0) * 255.0
				@cellule.set_color #Gdk::Color.new(color.red, color.green, color.blue)
			else
				if(not @cellule.isPossible?(@number))
					@cellule.addPossible(@number)
				else
					@cellule.delPossible(@number)
				end
        	end
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
