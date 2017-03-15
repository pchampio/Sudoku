require 'gtk3'

class Preference < Gtk::Frame

	def initialize(window)
		super()
		@window=window
		window.set_window_position Gtk::WindowPosition::CENTER
		
		event1 = Gtk::Box.new(:vertical,5)
		label_title = Gtk::Label.new "Changer les couleurs", :use_underline => true
    	picker = Gtk::ColorButton.new

    	print picker

		event1.add(label_title)
		event1.add(picker)

		picker.signal_connect("color-set"){
			puts picker.color
		}

		self.add event1

		show_all
	end

end

