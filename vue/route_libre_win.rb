require 'gtk3'

class FreeModeWin < Gtk::Frame

	def initialize(window)
		super()
		@window = window
		@window.set_window_position Gtk::WindowPosition::CENTER
		@window.set_title "Sudoku (Victoire)"

		txtTime = Gtk::Label.new "Vous avez fais votre grille en :"+"! Bravo", :use_underline => true
		imgVictoire = Gtk::Image.new :file => "./ressources/victoire.png"
	    boxVictoire = Gtk::Box.new(:vertical,2)
	    
	    color= Gdk::RGBA.new(2142, 42886, 46590, 65535)
	    txtTime.override_color(:normal, color)

	    boxVictoire.add(imgVictoire)
	    boxVictoire.add(txtTime)
	    self.add(boxVictoire)
		show_all
	end

end



#Pour les boutons retours, il faut qu'ils apparaissent dans la barre en haut
#la pause doit faire un save de la grille, temps (==> serial) affiche ecran noir, puis revient sur la grille deserialiser
#ajout du temps sur la victoire
#label des boutons a remplacer par des box / grilles
