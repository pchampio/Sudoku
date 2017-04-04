require 'gtk3'
require_relative "saveUser.rb"

class OverlayVictory < Gtk::Frame

<<<<<<< HEAD
	def initialize(nbStars,nbSec,difficulte)
		super()
		if(nbStars>2||nbStars<0)

		end

		#calcul des étoiles en fonction du temps
		if(difficulte==:easy&&nbSec<10)
			nbStars+=1
		elsif(difficulte==:normal&&nbSec<20)
			nbStars+=1
		elsif (difficulte==:difficile&&nbSec<30)
			nbStars+=1
		elsif(difficulte==:diabolik&&nbSec<40)
			nbStars+=1
		end 
		SaveUser.addEtoile(nbStars)


		txtTime = Gtk::Label.new "Bravo "+SaveUser.getUsername+" !\n\n Vous avez réalisé cette grille en : "+nbSec.to_i.to_s+"s ! \n", :use_underline => true
	    boxStars = Gtk::Box.new(:horizontal,3)
	    if(nbStars>0)
	    	boxStars.add(Gtk::Image.new(:file => "./ressources/starfull1.png"))
		else
			boxStars.add(Gtk::Image.new(:file => "./ressources/starempty1.png"))
		end
		if(nbStars>1)
	    	boxStars.add(Gtk::Image.new(:file => "./ressources/starfull1.png"))
		else
			boxStars.add(Gtk::Image.new(:file => "./ressources/starempty1.png"))
		end
		if(nbStars>2)
	    	boxStars.add(Gtk::Image.new(:file => "./ressources/starfull1.png"))
		else
			boxStars.add(Gtk::Image.new(:file => "./ressources/starempty1.png"))		
		end
	    txtStars = Gtk::Label.new "Vous avez obtenu "+nbStars.to_i.to_s+" étoile#{'s' if nbStars>0} !\n", :use_underline => true
	    boxVictoire = Gtk::Box.new(:vertical,4)
	    
	    buttEnd = Gtk::Button.new(:label=>"Continuer")
	    buttEnd.signal_connect("clicked"){
	    	self.continue()
	    }
	    
	    

	    boxVictoire.add txtTime
	    boxVictoire.add boxStars
	    boxVictoire.add txtStars
	    boxVictoire.add buttEnd



	    self.add(boxVictoire)

		
	end

	def continue()
		print "bonne continuation\n"
	end


end

