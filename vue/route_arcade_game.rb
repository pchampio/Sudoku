require 'gtk3'
require_relative '../class/board_class.rb'
require_relative '../class/cell_class.rb'
require_relative '../vue/component_board.rb'
require_relative '../vue/component_numpad.rb'
require_relative '../class/solver_class.rb'
require_relative '../vue/component_cell.rb'
#t=Time.now permet de calculer le temps mis par l'utilisateur pour résoudre le sudoku
#(t-=Time.now).to_i c'est l'affichage du temps mis en seconde pour résoudre le sudoku;
class ArcadeModeGame < Gtk::Frame

	attr_accessor :grid, :numpad
	def initialize(window,board)
		super()
		@board=board
		@window=window

		event1 = Gtk::Table.new(10,14,true)
		@grid = BoardComponent.new(self,@board)
		label_title = Gtk::Label.new "Arcade", :use_underline => true
		@numpad = NumpadComponent.create self


		event1.attach(label_title,0,3,0,1)
		event1.attach(@grid,0,9,1,9)
		event1.attach(@numpad,10,13,1,5)

		@cellule=@board.cellAt(0,0)
		self.add(event1)
		show_all
	end

	def recupereCell(cellule)
		@cellule=cellule
	end

	def recupereNumber(number)
		@number=number
    if(!@cellule.cell.freeze?)
      @cellule.cell.value=@number
      @cellule.set_value @number
    else
      print "La case est freeze\n"
    end
	end

end