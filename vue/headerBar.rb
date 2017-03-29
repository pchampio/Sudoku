#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: DEZERE Florian
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require "gtk3"

class HeadBar
	
	private_class_method :new
	
	def create(main_window, title, subtitle)
		initialize(main_window, title, subtitle)
	end

	def initialize(main_window, title, subtitle)
		@title, @subtitle = title, subtitle
		@window = Gtk::Window.new(:toplevel)
	    @window.screen = main_window.screen
	    @window.set_default_size(600, 400)

	    header = Gtk::HeaderBar.new()
	    header.show_close_button = true
	    header.title = @title
	    header.has_subtitle = true
	    header.subtitle = @subtitle

		buttonSettings = Gtk::Button.new()
			    
