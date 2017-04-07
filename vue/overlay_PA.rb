require 'gtk3'

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

class Pause < Overlay
	private_class_method :new

	def self.create(label_markup)
		new(label_markup)
	end

	def initialize(label_markup)
    super()

		img_starfull = File.dirname(__FILE__) + "/../ressources/starfull1little.png"

    overlayTitle = Gtk::Label.new label_markup
		overlayTitle.use_markup = true

		vbox = Gtk::Box.new :vertical, 5

		hbox = Gtk::Box.new :horizontal,2
		hbox.pack_start overlayTitle, :expand=>true, :fill=>true, :padding=>15
		vbox.pack_start hbox,:expand=>false, :fill=>false, :padding=>15

		hbox1=Gtk::Box.new :horizontal,2
		#hbox1.pack_start Gtk::Label.new('Vous avez : '+ SaveUser.getNbEtoile.to_s+" ☆"),:expand=>false, :fill=>false, :padding=>15
    hbox1.pack_start Gtk::Label.new(""),:expand=>false, :fill=>false, :padding=>5
		hbox1.pack_start Gtk::Label.new('Vous avez '+ SaveUser.getNbEtoile.to_s),:expand=>false, :fill=>false, :padding=>3
		hbox1.pack_start Gtk::Image.new(:file => img_starfull),:expand=>false, :fill=>false, :padding=>3
		vbox.pack_start hbox1,:expand=>false, :fill=>false, :padding=>15

		hbox2 = Gtk::Box.new(:horizontal, 2)
		hbox2.pack_start Gtk::Label.new('Vous avez joué '+Timer.getTimeAccueil(SaveUser.getTime)+""), :expand=>false, :fill=>false, :padding=>15
		vbox.pack_start hbox2, :expand=>false, :fill=>false, :padding=>15


		retour = Gtk::Button.new(:label=>"Continuer")
		vbox.pack_start retour, :expand=>false, :fill=>false, :padding=>15
		retour.style_context.add_class('suggested-action')
    retour.signal_connect "clicked" do
      self.destroy
    end

		vbox.halign = :CENTER
		vbox.valign = :CENTER
		hBox = Gtk::Box.new(:horizontal, 10)
    hBox.pack_start(vbox, :expand=>false, :fill=>false, :padding=>15)
    self.add hBox

	end

end
