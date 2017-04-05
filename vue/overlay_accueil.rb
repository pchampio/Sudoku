require 'gtk3'
require_relative 'saveUser.rb'
require_relative 'component_timer.rb'

class Accueil < Gtk::Frame


	def initialize
		super()
		username = Gtk::Label.new "<span weight='ultrabold' font='16'> "+SaveUser.getUsername+"</span>"
		username.use_markup = true
		vbox = Gtk::Box.new :vertical, 5
		vbox.pack_start username, :expand=>false, :fill=>false, :padding=>15

		hbox = Gtk::Box.new(:horizontal, 2)
		hbox.pack_start Gtk::Label.new('Vous avez : '+ SaveUser.getNbEtoile.to_s+" ☆"),:expand=>false, :fill=>false, :padding=>15
		# hbox.pack_end src, :expand=>false, :fill=>false, :padding=>15
		hbox.margin = 10
		vbox.pack_start hbox, :expand=>false, :fill=>false, :padding=>15

		vbox.add Gtk::Label.new 'Vous avez joué : '+Timer.getTimeFromSec(SaveUser.getTime)
		@retour = Gtk::Button.new(:label=>"continuer")
		vbox.pack_start @retour, :expand=>false, :fill=>false, :padding=>0

		vbox.halign = :CENTER
		vbox.valign = :CENTER
		self.add(vbox)
	end

  def signal_retour
    @retour.signal_connect("clicked") do
      yield
    end
  end

end
