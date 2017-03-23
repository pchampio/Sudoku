require 'gtk3'
require_relative '../class/board_class.rb'
require_relative '../class/generator_class.rb'

class TutoModeChoice < Gtk::Frame

	@difficulty = 0

	def initialize(window)
		super()
		@window=window
		@window.set_window_position Gtk::WindowPosition::CENTER
		@window.set_title "Sudoku (Choix de la difficulté)"
		@event1 = Gtk::Box.new(:vertical,5)
		@event1.set_homogeneous("r")
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
		pixAnim = GdkPixbuf::PixbufAnimation.new 'vue/image/anim.gif'
		image = Gtk::Image.new :animation => pixAnim
		difficultyBox.set_homogeneous("r")
		box = Gtk::Box.new(:horizontal,2)
		box.set_homogeneous("r")

		begginButton=Gtk::Button.new(:label=>"Commencer")
		begginButton.signal_connect("clicked"){commencerPartie}
		menuButton=Gtk::Button.new(:label=>"Retour")
		menuButton.signal_connect("clicked"){
			@window.remove self
			@window.add @window.event1
		}

		difficultyBox.add easyButton
		difficultyBox.add mediumButton
		difficultyBox.add difficultyButton

		box.add menuButton
		box.add begginButton
		box.add image
		@event1.add(difficultyBox)
		@event1.add box

		self.add @event1

		show_all
	end

	def commencerPartie()

		gameGen = Generator.new
		#@difficulty va être égale à la valeur du score du joueur

		puts("\n"+@difficulty+"\n")
		case @difficulty
		when 1
      gameGen.generate(:easy)
		when 2
      gameGen.generate(:medium)
		when 3
      gameGen.generate(:hard)
		else
      gameGen.generate(:easy)
		end

		@window.remove self
		#game = ArcadeModeGame.new(@window, gameGen.board)
		@window.add(game)
	end

end