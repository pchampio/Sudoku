require 'gtk3'

class FreeModeWin < Gtk::Frame

	def initialize(window)
		super()
		@window = window
		@window.set_window_position Gtk::WindowPosition::CENTER
		@window.set_title "Sudoku (Victoire)"

		victoire = Gtk::Image.new_from_file("../ressources/victoire.jpg")

		imageButton = Gtk::Button.new :label=>"Image", :image=>victoire
	
		@event = Gtk::Box.new(:vertical,2)
		@event.add(imageButton)
		self.add(victoire)
		show_all
	end

end
