require 'gtk3'
require_relative '../class/board_class.rb'
require_relative '../class/generator_class.rb'
require_relative '../vue/route_libre_game.rb'

class FreeModeWin < Gtk::Frame

	def initialize(window)
		super()
		@window = window
		@window.set_window_position Gtk::WindowPosition::CENTER
		@window.set_title "Sudoku (Victoire)"
		#victoire = Gdk::Pixbuf.new(:file => "../ressources/victoire.jpg")
		#image = Gtk::Image.new(:pixbuf => victoire)


		#@myViewport = Viewport.new(0, 0, 640, 480)
		#@mySprite = Sprite.new(@myViewport)
		#@myBitmap = RPG::Cache.picture("../ressources/victoire.png")
		#@mySprite.bitmap = @myBitmap
		#@window.add(@mySprite)
	end

end
