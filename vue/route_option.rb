require 'gtk3'
require_relative './serialisable.rb'

class Option < Gtk::Frame
	@@nom_fic = "sauvegarde.yml"
	def initialize(window)
		super()
		@window=window
		@window.set_title "Sudoku (Options)"
		@window.set_window_position Gtk::WindowPosition::CENTER

		box = Gtk::Box.new(:vertical,10)
		box.set_homogeneous("r")

		scpicker = Gtk::ColorButton.new
		bgpicker = Gtk::ColorButton.new

		label_background = Gtk::Label.new "Couleur Fond de Grille :", :use_underline => true

		
		print bgpicker
		bgpicker.signal_connect("color-set"){
			Serialisable.setBackgroundColor(bgpicker.color)
			puts "-----------------------------------------------------"
			print "la couleur de fond"
			puts bgpicker.color
		}


		label_selected_cell = Gtk::Label.new "Case selectionnée :", :use_underline => true

		
		print scpicker
		scpicker.signal_connect("color-set"){
			Serialisable.setSelectColor(scpicker.color)
			puts "-----------------------------------------------------"
			print "la couleur de selection"
			puts scpicker.color
		}

		menuButton=Gtk::Button.new(:label=>"Retour")
		menuButton.signal_connect("clicked"){
			Serialisable.serialized(@@nom_fic)
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