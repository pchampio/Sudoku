require 'gtk3'
require_relative 'saveUser.rb'
require_relative 'component_timer.rb'

class Accueil < Gtk::Frame


	def initialize
		super()
		username = Gtk::Label.new "<span weight='ultrabold' font='16'> Bienvenue "+SaveUser.getUsername+" !</span>"
		username.use_markup = true

		vbox = Gtk::Box.new :vertical, 5

		hbox0= Gtk::Box.new :horizontal, 1
		hbox0.pack_start username, :expand=>false, :fill=>false, :padding=>15
		vbox.pack_start hbox0,:expand=>false, :fill=>false, :padding=>15

		hbox1=Gtk::Box.new :horizontal,1
		hbox1.pack_start Gtk::Label.new('Vous avez : '+ SaveUser.getNbEtoile.to_s+" ☆"),:expand=>false, :fill=>false, :padding=>15
		vbox.pack_start hbox1,:expand=>false, :fill=>false, :padding=>15

		hbox2= Gtk::Box.new :horizontal,1
		hbox2.pack_start Gtk::Label.new('Vous avez joué '+Timer.getTimeAccueil(SaveUser.getTime)+"."),:expand=>false, :fill=>false, :padding=>15
		vbox.pack_start hbox2,:expand=>false, :fill=>false, :padding=>15

		@retour = Gtk::Button.new(:label=>"continuer")
		vbox.pack_start @retour, :expand=>false, :fill=>false, :padding=>0

		hbox0.halign = :CENTER
		hbox1.halign = :CENTER
		hbox2.halign = :CENTER

		self.add(vbox)
	end

  def signal_retour
    @retour.signal_connect("clicked") do
      yield
    end
  end

end
