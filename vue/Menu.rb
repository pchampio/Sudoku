require 'gtk3'

class Menu < Gtk::Window

	def initialize()
		super
		set_title "Bienvenue Sudoku"
		set_default_size 300, 300
		set_resizable true

		signal_connect 'destroy'  do
			Gtk.main_quit			
		end
		init_ui
	end

	def init_ui
		

		event1 = Gtk::VBox.new(true,5)
		label_title = Gtk::Label.new "Sudoku", true
		tutoButton = Gtk::Button.new "Tuto"
		arcadeButton = Gtk::Button.new "Arcade"
		freeModeButton = Gtk::Button.new "Libre"
		optionButton = Gtk::Button.new "Options"
		event1.add(label_title)
		event1.add(tutoButton)
		event1.add(arcadeButton)
		event1.add(freeModeButton)
		event1.add(optionButton)
		self.add event1

		show_all
	end

end

#Gtk.init
mene=Menu.new()
Gtk.main
