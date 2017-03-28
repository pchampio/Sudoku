require 'gtk3'

require_relative '../vue/route_option.rb'
require_relative '../vue/route_libre_choix.rb'
require_relative './serialisable.rb'

class Menu < Gtk::Window

  attr_reader :main_menu
	def initialize()
		super()
		set_title "Sudoku"
		set_default_size 300, 300
		set_resizable false
		set_window_position Gtk::WindowPosition::CENTER
		signal_connect 'destroy'  do
			Gtk.main_quit
		end

    Serialisable.load
		init_ui
	end

	def init_ui
		# https://lazka.github.io/pgi-docs/Gtk-3.0/classes/Box.html
		vBox = Gtk::Box.new(:vertical,5)
		vBox.set_homogeneous("r")
		label_title = Gtk::Label.new "Sudoku", :use_underline => true
		tutoButton = Gtk::Button.new :label=>"Tuto", :use_underline => true
		arcadeButton = Gtk::Button.new :label=>"Arcade", :use_underline => true
		freeModeButton = Gtk::Button.new :label=>"Libre", :use_underline => true
		optionButton = Gtk::Button.new :label=>"Options", :use_underline => true
		vBox.add(label_title)
		vBox.add(tutoButton)
		vBox.add(arcadeButton)
		vBox.add(freeModeButton)
		vBox.add(optionButton)

		optionButton.signal_connect("clicked"){
			remove(vBox)
			add(Option.new self)
		}

		freeModeButton.signal_connect("clicked"){
			remove(vBox)
			add(FreeModeChoice.new self)
		}
		arcadeButton.signal_connect("clicked"){
			remove(vBox)
			add(ArcadeModeChoice.new self)
		}
		tutoButton.signal_connect("clicked"){
			remove(vBox)
			add(TutoModeChoice.new self)
		}
		add vBox

    @main_menu = vBox

		show_all
	end

  def apply_cursor(name)
    cursor = Gdk::Cursor.new(name)
    self.window.set_cursor cursor
  end

end

#Gtk.init
Menu.new()
Gtk.main
