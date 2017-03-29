require 'gtk3'
require_relative './component_overlay.rb'
require_relative './serialisable.rb'
class OverlayOption < Overlay

	def initialize(main_window)
		super(main_window)
	end

	def init_ui
		super()
		vBox = Gtk::Box.new(:vertical,10)
		vBox.set_homogeneous("r")

    scpicker = Gtk::ColorButton.new(Serialisable.getSelectColor)
		bgpicker = Gtk::ColorButton.new(Serialisable.getBackgroundColor)
		cpicker = Gtk::ColorButton.new(Serialisable.getChiffreColor)

    bgHBox = Gtk::Box.new(:horizontal,3)
		label_background = Gtk::Label.new "Couleur du fond de la grille :", :use_underline => true
		bgpicker.signal_connect("color-set"){
   		   Serialisable.setBackgroundColor(bgpicker.color)
		}

    bgHBox.set_homogeneous("r")
    bgHBox.add label_background
    bgHBox.add bgpicker


    scHBox = Gtk::Box.new(:horizontal,3)
    label_selected_cell = Gtk::Label.new "Couleur de la case selectionnée :", :use_underline => true
		scpicker.signal_connect("color-set"){
			Serialisable.setSelectColor(scpicker.color)
		}

    scHBox.set_homogeneous("r")
    scHBox.add label_selected_cell
    scHBox.add scpicker


    cchiffHbox = Gtk::Box.new(:horizontal,3)
    label_num_color = Gtk::Label.new "Couleur des chiffres :", :use_underline => true
		cpicker.signal_connect("color-set"){
			Serialisable.setChiffreColor(cpicker.color)
		}
    cchiffHbox.set_homogeneous("r")
    cchiffHbox.add label_num_color
    cchiffHbox.add cpicker

		menuButton=Gtk::Button.new(:label=>"Retour")
		menuButton.signal_connect("clicked"){
      		Serialisable.serialized
			@window.remove self
			@window.add @window.main_menu
		}

    vBox.add bgHBox
    vBox.add scHBox
    vBox.add cchiffHbox
		vBox.add menuButton
		self.addComponent(vBox)

	end


end

window = Gtk::Window.new("First example")
window.set_size_request(400, 400)
window.set_border_width(10)

window.signal_connect("delete-event") { |_widget| Gtk.main_quit }

OverlayOption.new(window).run
Gtk.main