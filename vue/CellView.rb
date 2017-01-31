require 'gtk3'
require_relative '../class/cell_class.rb'

class CellView
	
	attr_accessor :button
	attr_accessor :cell

	def initialize(cell)
		@cell=cell
		if(@cell.value==0)
			@button=Gtk::Button.new(:label=>" ")
		else
			@button=Gtk::Button.new(:label=>@cell.value.to_s)
		end
	end
end
