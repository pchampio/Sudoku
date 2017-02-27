require 'gtk3'

class Option < Gtk::Frame

	def initialize(window)
		super()
		@window=window
		
		event1 = Gtk::VBox.new(true,5)
		label_title = Gtk::Label.new "Options", :use_underline => true
		event1.add(label_title)

		self.add event1

		show_all
	end

end

