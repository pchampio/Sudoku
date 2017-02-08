#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: Waibin Wang et Riviere Marius
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'
require_relative '../class/cell_class.rb'
##class CellView héritant (pour l'instant) de la classe Button
class CellView < Gtk::Button
##choix à faire : button, frame or widget ?
	
	##variables
	attr_accessor :button #c'est le bouton que renvoie la class CellView en guise de case
	attr_accessor :cell #c'est la case de cell_class.rb

	##constructeur
	#param cell : case de la grille de sudoku
	def initialize(cell)
		
		@cell=cell
		if(@cell.value==0)
			#@button=Gtk::Button.new(:label=>" ")
			super(:label=>" ",:use_underline => nil)
			
		else
			#@button=Gtk::Button.new(:label=>@cell.value.to_s)
			super(:label=>@cell.value.to_s,:use_underline => nil)
		end
		#set_border_width(0)
		#add(@button)
	end
end
