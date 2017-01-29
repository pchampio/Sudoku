require 'gtk2'

Gtk.init

def on_destroy()
	Gtk.main_quit
end

window = Gtk::Window.new()
window.set_title('Sudoku')
window.set_default_size(300,300)
window.set_resizable(true)
window.set_window_position(Gtk::Window::POS_CENTER_ALWAYS)

bQuit = Gtk::Button.new("Quitter")
bQuit.signal_connect('clicked'){on_destroy}

@un = Gtk::Label.new()
@un.set_text("1")

@table = Gtk::Table.new(9,9,true)
#@case11 = Gtk::Table.new(9,9,false)




#@case11.attach(@un,0,1,0,1)
#@table.attach(@case11,0,1,0,1)
@table.attach(bQuit,8,9,8,9)


window.add(@table)
window.show_all()

Gtk.main
