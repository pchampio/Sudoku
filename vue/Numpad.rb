require 'gtk3'
require_relative '../vue/GameMode.rb'


class Numpad < Gtk::Frame
	attr_accessor :valeur
	attr_reader :statut

	def initialize panel
		super()
		@panel=panel
		@valeur=0
		table = Gtk::Table.new(8,6,true)
		
		numButtons=Array.new(3){Array.new(3)}

		0.upto(2){|y|
			0.upto(2){|x|
				val=x+y*3+1
				numButtons[x][y]=Gtk::Button.new(:label=>val.to_s, :use_underline => true)
				numButtons[x][y].signal_connect("clicked"){
				@valeur=val
				@panel.recupereNumber(@valeur)
				}
				table.attach(numButtons[x][y],2*x,2*(x+1),2*y,2*(y+1))
			}
		}

		buttonPen = Gtk::RadioButton.new "Stylo"
		buttonPen.signal_connect('clicked'){statut=true}
		buttonCrayon = Gtk::RadioButton.new buttonPen,"Crayon"
		buttonCrayon.signal_connect('clicked'){statut=false}
		table.attach(buttonPen,0,3,7,8)
		table.attach(buttonCrayon,3,6,7,8)
		
		add(table)
		
		show_all()
	end

end