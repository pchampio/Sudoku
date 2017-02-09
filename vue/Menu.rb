require 'gtk3'
require_relative '../vue/OptionMode.rb'
require_relative '../vue/LibreMode.rb'

class Menu < Gtk::Window
	attr_accessor :event1
	def initialize()
		super()
		set_title "Bienvenue Sudoku"
		set_default_size 300, 300
		set_resizable true

		signal_connect 'destroy'  do
			Gtk.main_quit			
		end
		init_ui
	end

	def init_ui
		
		@event1 = Gtk::VBox.new(:vertical=>true,:spacing=>5)
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
		add(OptionMode.new self)
		}

		freeModeButton.signal_connect("clicked"){
		remove(@event1)
		add(LibreMode.new self)
		}
		add @event1

		show_all
	end
end

#Gtk.init
mene=Menu.new()
Gtk.main
