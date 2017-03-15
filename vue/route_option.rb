require 'gtk3'

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

		box.add menuButton
		@event1.add box
		self.add @event1

		show_all
	end

end