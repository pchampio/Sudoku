require 'gtk3'
require_relative '../class/board_class.rb'
require_relative '../class/generator_class.rb'
require_relative '../vue/GameMode.rb'

class FreeMode < Gtk::Frame
	@difficulty = 0

	def initialize(window)
		super()
		@window=window
		@event1 = Gtk::VBox.new(:vertical=>true,:spacing=>5)
		label_title = Gtk::Label.new "Jeu Libre", :use_underline => true
		label_difficulty = Gtk::Label.new "Difficulté :", :use_underline => true

		@event1.add(label_title)

		difficultyBox =Gtk::HBox.new(:vertical=>true,:spacing=>5).add(label_difficulty)
		box = Gtk::HBox.new(:vertical=>true,:spacing=>2)

		easyButton = Gtk::RadioButton.new :label => "Facile"
		easyButton.signal_connect("clicked") { @difficulty= 1 }
		mediumButton = Gtk::RadioButton.new :label => "Normal", :member => easyButton
		mediumButton.signal_connect("clicked") { @difficulty= 2 }
		difficultyButton = Gtk::RadioButton.new :label => "Difficile", :member => easyButton
		difficultyButton.signal_connect("clicked") { @difficulty= 3 }
		diabolikButton = Gtk::RadioButton.new :label => "Diabolique", :member => easyButton
		diabolikButton.signal_connect("clicked") { @difficulty= 4 }
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
		difficultyBox.add diabolikButton

		box.add menuButton
		box.add begginButton

		@event1.add(difficultyBox)
		@event1.add box

		self.add @event1

		show_all
	end

	def commencerPartie()

		x = Generator.new
		x.randomize
		#puts @difficulty
		case @difficulty
		when 1
			Generator.reduce(x.board,:easy)
		when 2
			Generator.reduce(x.board,:medium)
		when 3
			Generator.reduce(x.board,:hard)
		when 4
			Generator.reduce(x.board,:extreme)
		else
			Generator.reduce(x.board,:easy)
		end

		@window.remove self
		game = GameMode.new(@window,x.board)
		@window.add(game)
	end

end

