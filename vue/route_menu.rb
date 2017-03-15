
require 'gtk3'
require_relative '../vue/route_option.rb'
require_relative '../vue/route_libre_choix.rb'
require_relative './route_arcade_choix.rb'

class Menu < Gtk::Window

	attr_accessor :event1

	def initialize()
		super()
		set_title "Sudoku"
		set_default_size 300, 300
		set_resizable false
		set_window_position Gtk::WindowPosition::CENTER
		signal_connect 'destroy'  do
			Gtk.main_quit
		end
		init_ui
	end

	def init_ui
		# https://lazka.github.io/pgi-docs/Gtk-3.0/classes/Box.html
		@event1 = Gtk::Box.new(:vertical,5)
		@event1.set_homogeneous("r")
		label_title = Gtk::Label.new "Sudoku", :use_underline => true
		tutoButton = Gtk::Button.new :label=>"Tuto", :use_underline => true
		arcadeButton = Gtk::Button.new :label=>"Arcade", :use_underline => true
		freeModeButton = Gtk::Button.new :label=>"Libre", :use_underline => true
		optionButton = Gtk::Button.new :label=>"Options", :use_underline => true
		@event1.add(label_title)
		@event1.add(tutoButton)
		@event1.add(arcadeButton)
		@event1.add(freeModeButton)
		@event1.add(optionButton)

		optionButton.signal_connect("clicked"){
			remove(@event1)
			add(Option.new self)
		}

		freeModeButton.signal_connect("clicked"){
			remove(@event1)
			add(FreeModeChoice.new self)
		}
		arcadeButton.signal_connect("clicked"){
			remove(@event1)
			add(ArcadeModeChoice.new self)
		}
		add @event1

		show_all
	end
end

#Gtk.init
Menu.new()
Gtk.main
