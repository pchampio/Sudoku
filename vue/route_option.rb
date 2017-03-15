require 'gtk3'
require_relative 'serialisable.rb'


class Option < Gtk::Frame

	def initialize(window)
		super()
		@window=window
		@window.set_title "Sudoku (Options)"
		@window.set_window_position Gtk::WindowPosition::CENTER

		box = Gtk::Box.new(:vertical,10)
		box.set_homogeneous("r")


		label_background = Gtk::Label.new "Couleur Fond de Grille :", :use_underline => true

		bgpicker = Gtk::ColorButton.new
		print bgpicker
		bgpicker.signal_connect("color-set"){
			puts bgpicker.color
		}


		label_selected_cell = Gtk::Label.new "Case selectionnée :", :use_underline => true

		scpicker = Gtk::ColorButton.new
		print scpicker
		bgpicker.signal_connect("color-set"){
			puts scpicker.color
		}

		menuButton=Gtk::Button.new(:label=>"Retour")
		menuButton.signal_connect("clicked"){
			@window.remove self
			@window.add @window.event1
		}

		box.add(label_background)
		box.add bgpicker
		box.add label_selected_cell
		box.add scpicker
		box.add menuButton
		self.add box

		show_all
	end

end