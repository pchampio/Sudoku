require 'gtk3'
require_relative '../class/board_class.rb'
require_relative '../class/cell_class.rb'
require_relative '../vue/GridPanel.rb'
require_relative '../vue/Numpad.rb'
require_relative '../class/solver_class.rb'
require_relative '../vue/CellView.rb'

class GameMode < Gtk::Frame

	def initialize(window,board)
		super()
		@board=board
		@window=window

		event1 = Gtk::Table.new(10,14,true)
		grid = GridPanel.new(self,@board)
		label_title = Gtk::Label.new "Jeu Libre", :use_underline => true
		numpad = Numpad.create self


		event1.attach(label_title,0,3,0,1)		
		event1.attach(grid,0,9,1,9)
		event1.attach(numpad,10,13,1,5)

		@solver = Solver.creer @board
		@solver.solveLogic
		@solver.solve

		@cellule=@board.cellAt(0,0)
		self.add(event1)
		show_all
	end
	
	def recupereCell(cellule)
		@cellule=cellule
	end

	def recupereNumber(number)
		@number=number
		if(@cellule.cell.value==0)
			#puts @cellule.cell.row
			#puts @cellule.cell.col
			#puts @solver.board.cellAt(@cellule.cell.row , @cellule.cell.col).value
			if(@solver.board.cellAt(@cellule.cell.row , @cellule.cell.col).value==@number)
				@cellule.cell.value=@number
				@cellule.set_label @number.to_s
			else
				puts "nombre pas valide"
			end
		else
			puts "case déjà remplie"
		end

	end

end