require 'gtk3'
require_relative '../class/board_class.rb'
require_relative '../class/generator_class.rb'
require_relative '../vue/GameMode.rb'

class LibreMode < Gtk::Frame

	def initialize(window)
		super()
		@window=window
		@event1 = Gtk::VBox.new(:vertical=>true,:spacing=>5)
		label_title = Gtk::Label.new "Jeu Libre", :use_underline => true
		label_difficulty = Gtk::Label.new "Difficulté :", :use_underline => true
		begginButton=Gtk::Button.new(:label=>"Commencer")
		begginButton.signal_connect("clicked"){commencerPartie}
		@event1.add(label_title)
		@event1.add(Gtk::VBox.new(:vertical=>true,:spacing=>2).add(label_difficulty))
		@event1.add(begginButton)
			
		self.add @event1

		show_all
	end

	def commencerPartie()

		x = Generator.new
		x.randomize
		Generator.reduce(x.board,:easy)
		
		@window.remove self		
		game = GameMode.new(@window,x.board)
		@window.add(game)
	end

end

