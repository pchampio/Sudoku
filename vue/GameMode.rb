require 'gtk3'
require_relative '../class/board_class.rb'
require_relative '../vue/GridPanel.rb'

class GameMode < Gtk::Frame

	def initialize(window,board)
		super()
		@board=board
		@window=window

		event1 = Gtk::VBox.new(:vertical=>false,:spacing=>5)
		grid = GridPanel.new(@board)
		label_title = Gtk::Label.new "Jeu Libre", :use_underline => true
		event1.add(label_title)		
		
		event1.add(grid)
		self.add(event1)
		show_all
	end

end
