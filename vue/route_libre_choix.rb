require 'gtk3'
require 'thread'

require_relative '../class/board_class.rb'
require_relative '../class/generator_class.rb'
require_relative '../vue/route_libre_game.rb'

class FreeModeChoice < Gtk::Frame
	@difficulty = 0

	def initialize(window)
		super()
		@window=window
		@window.set_window_position Gtk::WindowPosition::CENTER
		@window.set_title "Sudoku (Choix de la difficulté)"
		vBox = Gtk::Box.new(:vertical,5)
		vBox.set_homogeneous("r")
		label_difficulty = Gtk::Label.new "Difficulté :", :use_underline => true


		difficultyBox =Gtk::Box.new(:horizontal,5).add(label_difficulty)
		difficultyBox.set_homogeneous("r")
		box = Gtk::Box.new(:horizontal,2)
		box.set_homogeneous("r")

		easyButton = Gtk::RadioButton.new :label => "Facile"
		easyButton.signal_connect("clicked") { @difficulty= 1 }
		mediumButton = Gtk::RadioButton.new :label => "Normal", :member => easyButton
		mediumButton.signal_connect("clicked") { @difficulty= 2 }
		difficultyButton = Gtk::RadioButton.new :label => "Difficile", :member => easyButton
		difficultyButton.signal_connect("clicked") { @difficulty= 3 }
		diabolikButton = Gtk::RadioButton.new :label => "Diabolique", :member => easyButton
		diabolikButton.signal_connect("clicked") { @difficulty= 4 }

		begginButton=Gtk::Button.new(:label=>"Commencer")
		begginButton.signal_connect("clicked"){
      @window.apply_cursor("wait")

      # @genBoard = Thread.new do
        board = generateBoard # can take some time
        @window.apply_cursor("default")
        @window.remove self
        game = FreeModeGame.new(@window, board)
        @window.add(game)
      # end
    }

		menuButton=Gtk::Button.new(:label=>"Retour")
		menuButton.signal_connect("clicked"){
      @genBoard.kill if @genBoard
      @window.remove self
			@window.add @window.main_menu
      # @window.apply_cursor("default")
		}


		difficultyBox.add easyButton
		difficultyBox.add mediumButton
		difficultyBox.add difficultyButton
		difficultyBox.add diabolikButton

		box.add menuButton
		box.add begginButton

		vBox.add(difficultyBox)
		vBox.add box

		self.add vBox

    show_all
	end

	def generateBoard()
		gameGen = Generator.new
		case @difficulty
		when 1
      gameGen.generate(:easy)
		when 2
      gameGen.generate(:medium)
		when 3
      gameGen.generate(:hard)
		when 4
      gameGen.generate(:extreme)
		else
      gameGen.generate(:easy)
		end
    return gameGen.board
	end

end

