require 'gtk2'
load 'GrillePanel.rb'
load '../class/board_class.rb'
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

planche_base = "
  _ _ _   _ _ 4   _ _ _
  _ _ _   _ _ 3   _ _ 9
  _ 8 _   _ _ 1   _ _ 2

  _ _ 4   _ 6 8   _ _ _
  7 _ _   _ _ _   8 _ _
  9 _ _   4 _ _   _ 5 6

  _ 3 _   _ 2 _   _ _ _
  6 9 _   _ 5 _   _ 2 _
  _ _ 7   1 _ _   _ _ _
    ".tr("_", "0")

board = Board.creer(planche_base.delete("\s|\n")
      .split("").reverse.map(&:to_i))
@grille=GrillePanel.new(board)


window.add(@grille.boardView())
window.show_all()

Gtk.main
