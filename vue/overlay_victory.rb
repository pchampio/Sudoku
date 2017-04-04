require 'gtk3'

class OverlayVictory < Gtk::Frame

  def initialize(nbStars,nbSec,difficulte)
    super()
    if(nbStars>2||nbStars<0)

    end



    txtTime = Gtk::Label.new "Bravo "+SaveUser.getUsername+"!\n\n Vous avez réalisé cette grille en : "+nbSec.to_i.to_s+"s ! \n", :use_underline => true
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
    txtStars = Gtk::Label.new "Vous avez obtenu "+nbStars.to_i.to_s+" étoiles !\n", :use_underline => true
    boxVictoire = Gtk::Box.new(:vertical,4)

    buttEnd = Gtk::Button.new(:label=>"Continuer")
    buttEnd.signal_connect("clicked"){
      self.continue()
    }
    color= Gdk::RGBA.new(100, 42886, 46590, 65535)
    txtTime.override_color(:normal, color)
    txtStars.override_color(:normal,color)


    boxVictoire.add txtTime
    boxVictoire.add boxStars
    boxVictoire.add txtStars
    boxVictoire.add buttEnd

    #boxVictoire.pack_start(boxStars, :expand=>true, :fill=>true, :padding=>15)
    #boxVictoire.pack_start(txtTime, :expand=>false, :fill=>true, :padding=>15)
    #boxVictoire.pack_start(txtStars, :expand=>false, :fill=>true, :padding=>15)

    self.add(boxVictoire)
  end

  def continue()
    print "bonne continuation\n"
  end

end

