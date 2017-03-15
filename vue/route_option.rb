require 'gtk3'
require_relative '../vue/route_preference.rb'

class Option < Gtk::Frame

	def initialize(window)
		super()
		@window=window
		@window.set_window_position Gtk::Window::Position::CENTER
		event1 = Gtk::Box.new(:vertical,5)
		label_title = Gtk::Label.new "Options", :use_underline => true
		changeColorButton = Gtk::Button.new :label=>"Changer les couleurs", :use_underline => true

		event1.add(label_title)
		event1.add(changeColorButton)

		changeColorButton.signal_connect("clicked"){
			remove(event1)
			add(Preference.new self)
		}

		add event1

		show_all
	end

end

