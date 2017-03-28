require 'gtk3'

class Pause < Gtk::Frame

	def initialize(window)
		super()
		@window = window
		@window.set_window_position Gtk::WindowPosition::CENTER
		@window.set_title "Sudoku (Pause)"
		#faire une image noir de 300 par 300?
		#@window.override_background_color = :normal, Gdk::Color.new(0, 0,0)

		show_all
	end

end
