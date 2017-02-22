require 'gtk3'
require_relative '../vue/GameMode.rb'


class Numpad < Gtk::Frame
	attr_accessor :valeur
	def initialize panel
		super()
		@panel=panel
		@valeur=0
		table = Gtk::Table.new(3,3,true)
		
		numButtons=Array.new(3){Array.new(3)}

		0.upto(2){|y|
			0.upto(2){|x|
				val=x+y*3+1
				numButtons[x][y]=Gtk::Button.new(:label=>val.to_s, :use_underline => true)
				numButtons[x][y].signal_connect("clicked"){
				@valeur=val
				@panel.recupereNumber(@valeur)
				}
				table.attach(numButtons[x][y],x,x+1,y,y+1)
				
			}
		}

		add(table)
		
		show_all()
	end

end