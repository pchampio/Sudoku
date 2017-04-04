require 'gtk3'
require_relative "saveUser.rb"

class OverlayVictory < Gtk::Frame

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
		SaveUser.setTime(SaveUser.getTime()+nbSec)

		txtTime = Gtk::Label.new "<span weight='ultrabold' font='16'>Bravo "+SaveUser.getUsername+" !</span>\n\n Vous avez réalisé cette grille en : "+nbSec.to_i.to_s+"s ! \n", :use_underline => true
   		txtTime.use_markup = true

	    boxStars = Gtk::Box.new(:horizontal,3)
	    if(nbStars>0)
	    	boxStars.pack_start(Gtk::Image.new(:file => "./ressources/starfull1.png"),:expand=>false, :fill=>false, :padding=>15)
		else
			boxStars.pack_start(Gtk::Image.new(:file => "./ressources/starempty1.png"),:expand=>false, :fill=>false, :padding=>15)
		end
		if(nbStars>1)
	    	boxStars.add(Gtk::Image.new(:file => "./ressources/starfull1.png"))
		else
			boxStars.add(Gtk::Image.new(:file => "./ressources/starempty1.png"))
		end
		if(nbStars>2)
	    	boxStars.pack_end(Gtk::Image.new(:file => "./ressources/starfull1.png"),:expand=>false, :fill=>false, :padding=>15)
		else
			boxStars.pack_end(Gtk::Image.new(:file => "./ressources/starempty1.png"),:expand=>false, :fill=>false, :padding=>15)
		end
	    txtStars = Gtk::Label.new "Vous avez obtenu "+nbStars.to_i.to_s+" étoile#{'s' if nbStars>0} !\n", :use_underline => true
	    boxVictoire = Gtk::Box.new(:vertical,4)
	    
	    buttEnd = Gtk::Button.new(:label=>"Continuer")
	    buttEnd.signal_connect("clicked"){
	    	self.continue()
	    }
	    
	    

	    boxVictoire.pack_start(txtTime, :expand=>false, :fill=>false, :padding=>15)
	    boxVictoire.pack_start(boxStars, :expand=>false, :fill=>false, :padding=>2)
	    boxVictoire.pack_start(txtStars, :expand=>false, :fill=>false, :padding=>2)
	    boxVictoire.pack_end(buttEnd, :expand=>false, :fill=>false, :padding=>0)
	    self.add(boxVictoire)

		
	end

	def continue()
		print "bonne continuation\n"
	end


end

