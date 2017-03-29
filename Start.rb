#!/usr/bin/env ruby

require_relative './vue/route_libre_game.rb'
require_relative './class/generator_class.rb'




	window= Gtk::Window.new
	window.set_title "Sudoku"
	window.set_default_size 300, 300
	window.set_resizable false
	window.set_window_position Gtk::WindowPosition::CENTER
	window.signal_connect 'destroy'  do
		Gtk.main_quit
	end

    Serialisable.load

    a=Generator.new
    a.generate(:easy)


FreeModeGame.new(window,a.board)
Gtk.main
window.show_all


#header bar doit connaitre temps ==> methode d'acces header bar
#afficher masquer élément header bar via méthod