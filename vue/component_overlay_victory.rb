require 'gtk3'
require_relative './component_overlay.rb'

class OverlayVictory < Overlay

	def initialize(main_window)
		super(main_window)
	end

	def init_ui
		super()
		txtTime = Gtk::Label.new "Vous avez fais votre grille en : "+0.to_s+"s ! Bravo", :use_underline => true
	    boxVictoire = Gtk::Box.new(:vertical,2)
	    
	    color= Gdk::RGBA.new(2142, 42886, 46590, 65535)
	    txtTime.override_color(:normal, color)

	    boxVictoire.add(txtTime)
		self.addComponent(boxVictoire)

	end


end

window = Gtk::Window.new("First example")
window.set_size_request(400, 400)
window.set_border_width(10)

window.signal_connect("delete-event") { |_widget| Gtk.main_quit }

OverlayVictory.new(window).run
Gtk.main