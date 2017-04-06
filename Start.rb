#!/usr/bin/env ruby

require 'gtk3'

Dir[File.dirname(__FILE__) + '/vue/*.rb'].each {|file|  require file }
require_relative './class/generator_class.rb'


window= Gtk::Window.new
window.set_title "Sudoku"
window.set_default_size 300, 300
window.set_resizable false
window.set_window_position Gtk::WindowPosition::CENTER

window.signal_connect 'destroy'  do
	SaveUser.serialized
	Gtk.main_quit
end


GlobalOpts.load
SaveUser.load

gen=Generator.new
gen.generate(:full)

window.add Game.new(window,gen.board)

window.show_all
Gtk.main
