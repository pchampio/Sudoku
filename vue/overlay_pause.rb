require 'gtk3'
require_relative 'saveUser.rb'
require_relative 'component_timer.rb'

class Pause < Gtk::Frame


	def initialize
		img_starfull = File.dirname(__FILE__) + "/../ressources/starfull1little.png"

		super()
		username = Gtk::Label.new "<span weight='ultrabold' font='16'>Pause</span>"
		username.use_markup = true

		vbox = Gtk::Box.new :vertical, 5

		hbox = Gtk::Box.new :horizontal,2
		hbox.pack_start username, :expand=>false, :fill=>false, :padding=>15
		vbox.pack_start hbox,:expand=>false, :fill=>false, :padding=>15

		hbox1=Gtk::Box.new :horizontal,2
		#hbox1.pack_start Gtk::Label.new('Vous avez : '+ SaveUser.getNbEtoile.to_s+" ☆"),:expand=>false, :fill=>false, :padding=>15
    hbox1.pack_start Gtk::Label.new(""),:expand=>false, :fill=>false, :padding=>5
		hbox1.pack_start Gtk::Label.new('Vous avez : '+ SaveUser.getNbEtoile.to_s),:expand=>false, :fill=>false, :padding=>3
		hbox1.pack_start Gtk::Image.new(:file => img_starfull),:expand=>false, :fill=>false, :padding=>3
		vbox.pack_start hbox1,:expand=>false, :fill=>false, :padding=>15

		hbox2 = Gtk::Box.new(:horizontal, 2)
		hbox2.pack_start Gtk::Label.new('Vous avez joué '+Timer.getTimeAccueil(SaveUser.getTime)+"."), :expand=>false, :fill=>false, :padding=>15
		vbox.pack_start hbox2, :expand=>false, :fill=>false, :padding=>15


		@retour = Gtk::Button.new(:label=>"continuer")
		vbox.pack_start @retour, :expand=>false, :fill=>false, :padding=>15
		@retour.style_context.add_class('suggested-action')

		vbox.halign = :CENTER
		vbox.valign = :CENTER
		hBox = Gtk::Box.new(:horizontal, 10)
	    hBox.pack_start(vbox, :expand=>false, :fill=>false, :padding=>15)
	    self.add hBox
	end

  def signal_retour
    @retour.signal_connect("clicked") do
      yield
    end
  end

end
