require 'gtk3'

class Menu < Gtk::Window

	def initialize()
		super
		set_title "Bienvenue Suduko"
		set_default_size 300, 300
		set_resizable true

		signal_connect 'destroy'  do
			Gtk.main_quit			
		end
		init_ui
	end

	def init_ui
		

		event1 = Gtk::EventBox.new
		label_turial = Gtk::Label.new "Turial", true
		event1.add(label_turial)

		self.add event1

		show_all
	end

end

#Gtk.init
mene=Menu.new()
Gtk.main