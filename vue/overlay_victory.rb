require 'gtk3'
require_relative "saveUser.rb"

class OverlayVictory < Gtk::Frame

  def initialize(nbStars,nbSec,difficulte)
    super()

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

    img_starempty = File.dirname(__FILE__) + "/../ressources/starempty1.png"
    img_starfull = File.dirname(__FILE__) + "/../ressources/starfull1.png"

    SaveUser.addEtoile(nbStars)
    SaveUser.setTime(SaveUser.getTime()+nbSec)
    SaveUser.serialized

    txtTime = Gtk::Label.new "<span weight='ultrabold' font='16'>Bravo "+SaveUser.getUsername+" !</span>\n\n Vous avez réalisé cette grille en : "+nbSec.to_i.to_s+"s ! \n", :use_underline => true
    txtTime.use_markup = true

    boxStars = Gtk::Box.new(:horizontal,3)
    nbStars.times do
      boxStars.pack_start(Gtk::Image.new(:file => img_starfull),:expand=>false, :fill=>false, :padding=>15)
    end
    (3-nbStars).times do
      boxStars.pack_start(Gtk::Image.new(:file => img_starempty),:expand=>false, :fill=>false, :padding=>15)
    end
    txtStars = Gtk::Label.new "Vous avez obtenu #{nbStars} étoile#{'s' if nbStars>1} !\n", :use_underline => true
    boxVictoire = Gtk::Box.new(:vertical,4)

    @buttEnd = Gtk::Button.new(:label=>"Continuer")

    boxVictoire.pack_start(txtTime, :expand=>false, :fill=>false, :padding=>15)
    boxVictoire.pack_start(boxStars, :expand=>false, :fill=>false, :padding=>2)
    boxVictoire.pack_start(txtStars, :expand=>false, :fill=>false, :padding=>2)
    boxVictoire.pack_end(@buttEnd, :expand=>false, :fill=>false, :padding=>0)
    self.add(boxVictoire)


  end

  def signal_retour
    @buttEnd.signal_connect "clicked" do
      yield
    end
  end

end

