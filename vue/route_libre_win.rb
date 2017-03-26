require 'gtk3'

class FreeModeWin < Gtk::Frame

	def initialize(window)
		super()
		@window = window
		@window.set_window_position Gtk::WindowPosition::CENTER
		@window.set_title "Sudoku (Victoire)"

		imgVictoire = Gtk::Image.new :file => "./ressources/victoire.png"
	    boxVictoire = Gtk::Box.new(:horizontal,1)
	    boxVictoire.add(imgVictoire)
	    self.add(boxVictoire)
		show_all
	end

end



#Pour les boutons retours, il faut qu'ils apparaissent dans la barre en haut
#la pause doit faire un save de la grille, temps (==> serial) affiche ecran noir, puis revient sur la grille deserialiser
#ajout du temps sur la victoire
#label des boutons a remplacer par des box / grilles
