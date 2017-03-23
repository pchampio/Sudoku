require 'gtk3'

class FreeModeWin < Gtk::Frame

	def initialize(window)
		super()
		@window = window
		@window.set_window_position Gtk::WindowPosition::CENTER
		@window.set_title "Sudoku (Victoire)"
		imageButton = Gtk::Button.new :label=>"Image"
	
		victoire = Gtk::Image.new(:file => "../ressources/victoire.jpg")
		imageButton.set_image(victoire)
		@event = Gtk::Box.new(:vertical,2)
		@event.add(imageButton)
		self.add(victoire)
		#@myViewport = Viewport.new(0, 0, 640, 480)
		#@mySprite = Sprite.new(@myViewport)
		#@myBitmap = RPG::Cache.picture("../ressources/victoire.png")
		#@mySprite.bitmap = @myBitmap
		#@window.add(@mySprite)
		show_all
	end

end
