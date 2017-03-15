require 'gtk3'
#require_relative '../vue/route_preference.rb'

class Option < Gtk::Frame

	def initialize(window)
		super()
		@window=window
		window.set_window_position Gtk::WindowPosition::CENTER

		@event1 = Gtk::Box.new(:vertical,2)
		@event1.set_homogeneous("r")
		label_title = Gtk::Label.new "Choix de couleur :", :use_underline => true
		@event1.add(label_title)

		box = Gtk::Box.new(:vertical,2)
		box.set_homogeneous("r")

		menuButton=Gtk::Button.new(:label=>"Retour")
		menuButton.signal_connect("clicked"){
			@window.remove self
			@window.add @window.event1
		}

		picker = Gtk::ColorButton.new
		print picker
		picker.signal_connect("color-set"){
			puts picker.color
		}

		box.add picker
		box.add menuButton
		@event1.add box
		self.add @event1

		show_all
	end

end