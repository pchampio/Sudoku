require 'gtk3'

class OverlayVictory < Gtk::Frame

	def initialize(nbStars,nbSec,difficulte)
		super()
		
		txtTime = Gtk::Label.new "Vous avez fais cette grille en : "+nbSec.to_i.to_s+"s ! Bravo !\n", :use_underline => true
	    txtStars = Gtk::Label.new "Vous avez obtenu "+nbStars.to_i.to_s+" étoiles !\n", :use_underline => true
	    boxVictoire = Gtk::Box.new(:vertical,2)
	    
	    buttEnd = Gtk::Button.new(:label=>"Continuer")
	    buttEnd.signal_connect("clicked"){
	    	self.continue()
	    }
	    color= Gdk::RGBA.new(100, 42886, 46590, 65535)
	    txtTime.override_color(:normal, color)
	    txtStars.override_color(:normal,color)
	    boxVictoire.add txtTime
	    boxVictoire.add txtStars
	    boxVictoire.add buttEnd

	    self.add(boxVictoire)
	end

	def continue()
		print "bonne continuation\n"
	end

end

