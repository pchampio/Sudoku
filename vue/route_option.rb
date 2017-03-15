require 'gtk3'
require_relative '../vue/route_preference.rb'

class Option < Gtk::Frame

	def initialize(window)
		super()
		@window=window

		@event1 = Gtk::Box.new(:vertical,5)
		@event1.set_homogeneous("r")
		label_title = Gtk::Label.new "Options", :use_underline => true
		@event1.add(label_title)

		box = Gtk::Box.new(:horizontal,2)
		box.set_homogeneous("r")

		menuButton=Gtk::Button.new(:label=>"Retour")
		menuButton.signal_connect("clicked"){
			@window.remove self
			@window.add @window.event1
		}

		changeColorButton = Gtk::Button.new :label=>"Changer les couleurs", :use_underline => true
		changeColorButton.signal_connect("clicked"){
			remove(event1)
			add(Preference.new self)
		}

		box.add menuButton
		box.add(changeColorButton)
		@event1.add box
		self.add @event1

		show_all
	end

end