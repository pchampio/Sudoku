require 'gtk3'

class App < Gtk::Window
	def initialize
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
			vbox = Gtk::Box.new :vertical, 10
			button1 = Gtk::Button.new :label=>"backgroud is blue"
			button1.override_background_color Gtk::StateType::NORMAL,Gdk::Color.new(0,0,65532)
			#button1.signal_connect('clicked') do
			#		button1.modify_bg(Gtk::STATE_NORMAL,Gdk::Color.new(0,65532,0))
			#end
			button1.override_backgroud_color Gtk::StateType::SELECTED, Gdk::Color.new(0,65532,0)
			button1.override_backgroud_color(Gtk::StateType::PRELIGHT, Gdk::Color.new(0,65532,0))
			button2 = Gtk::Button.new :label=>"text is green" 
			button2.child.override_color Gtk::StateType::NORMAL, Gdk::Color.new(0,65532,0)
			vbox.add(button1)
			vbox.add(button2)
			add(vbox)
			show_all
		end
end

App.new
Gtk.main()
