require 'gtk3'
require_relative '../class/cell_class.rb'

class CellView < Gtk::Button
##choix à faire : button, frame or widget ?
	attr_accessor :button
	attr_accessor :cell

	def initialize(cell)
		
		@cell=cell
		if(@cell.value==0)
			#@button=Gtk::Button.new(:label=>" ")
			super(" ")
			
		else
			#@button=Gtk::Button.new(:label=>@cell.value.to_s)
			super(:label=>@cell.value.to_s)
		end
		#set_border_width(0)
		#add(@button)
	end
end
