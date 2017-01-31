require 'gtk3'
require_relative '../class/cell_class.rb'

class CellView < Gtk::Button
	

	def initialize(cell)
		@cell=cell
		if cell.value==0
			super(:label=>" ")
		else
			super(:label=>cell.value.to_s)
		end
		
	end
end
