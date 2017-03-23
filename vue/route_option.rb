require 'gtk3'
require_relative './serialisable.rb'

class Option < Gtk::Frame
	def initialize(window)
		super()
		@window=window
		@window.set_title "Sudoku (Options)"
		@window.set_window_position Gtk::WindowPosition::CENTER

		box = Gtk::Box.new(:vertical,10)
		box.set_homogeneous("r")

		scpicker = Gtk::ColorButton.new
		bgpicker = Gtk::ColorButton.new
		cpicker = Gtk::ColorButton.new

		label_background = Gtk::Label.new "Couleur du fond de la grille :", :use_underline => true
		bgpicker.signal_connect("color-set"){
   		   Serialisable.setBackgroundColor(bgpicker.color)
		}


		label_selected_cell = Gtk::Label.new "Couleur de la case selectionnée :", :use_underline => true

		scpicker.signal_connect("color-set"){
			Serialisable.setSelectColor(scpicker.color)
		}

		label_num_color = Gtk::Label.new "Couleur des chiffres :", :use_underline => true

		cpicker.signal_connect("color-set"){
			Serialisable.setChiffreColor(cpicker.color)
		}

		menuButton=Gtk::Button.new(:label=>"Retour")
		menuButton.signal_connect("clicked"){
      		Serialisable.serialized
			@window.remove self
			@window.add @window.event1
		}

		box.add label_background
		box.add bgpicker
		box.add label_num_color
		box.add cpicker
		box.add label_selected_cell
		box.add scpicker
		box.add menuButton
		self.add box

		show_all
	end

end
