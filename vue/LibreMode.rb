require 'gtk3'

class LibreMode < Gtk::Frame

	def initialize(window)
		super()
		@window=window
		event1 = Gtk::VBox.new(true,5)
		label_title = Gtk::Label.new "Jeu Libre", :use_underline => true
		label_difficulty = Gtk::Label.new "Difficulté :", :use_underline => true
		
		
		event1.add(label_title)
		event1.add(Gtk::VBox.new(true,2).add(label_difficulty))
		self.add event1

		show_all
	end

end

