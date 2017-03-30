#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: DEZERE Florian
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'
require_relative './serialisable.rb'

class Option < Gtk::Frame
	def initialize(window)#:nodoc:
		super()
		@window=window
		@window.set_title "Sudoku (Options)"
		@window.set_window_position Gtk::WindowPosition::CENTER

		vBox = Gtk::Box.new(:vertical,10)
		vBox.set_homogeneous("r")

		scpicker = Gtk::ColorButton.new(Serialisable.getSelectColor)
		bgpicker = Gtk::ColorButton.new(Serialisable.getBackgroundColor)
		cpicker = Gtk::ColorButton.new(Serialisable.getChiffreColor)
		surlignepicker = Gtk::ColorButton.new(Serialisable.getSurligneColor)

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

		cSurlignHbox = Gtk::Box.new(:horizontal, 3)
		label_surligne_color = Gtk::Label.new "Couleur de surlignage", :use_underline => true
		surlignepicker.signal_connect("color-set"){
			Serialisable.setSurligneColor(surlignepicker.color)
		}
		cSurlignHbox.set_homogeneous("r")
		cSurlignHbox.add label_surligne_color
		cSurlignHbox.add surlignepicker

		entry_username = Gtk::Entry.new
		entry_username.set_max_length(15)
		entry_username.set_texte(`logname`)
		Serialisable.setUsername(`logname`)
		entry_username.signal_connect("entry"){
			Serialisable.setUsername(entry_username.get_text())
		}

		menuButton=Gtk::Button.new(:label=>"Retour")
		menuButton.signal_connect("clicked"){
			Serialisable.serialized
			@window.remove self
			@window.add @window.main_menu
		}

		#faire hbox pour avoir switch avec champs texte comme dans component in game menu
		erreurAutoriserHBox = Gtk::Box.new(:horizontal,5)
		labelErreurAutoriser = Gtk::Label.new("Permettre l'autorisation des erreurs")
		switchErreurAutoriser = Gtk::Switch.new
		switchErreurAutoriser.signal_connect('state-set') do
			erreurAutoriser = switchErreurAutoriser.active?
			Serialisable.setErreurAutoriser(erreurAutoriser)
			switchErreurAutoriser.state = erreurAutoriser
		end
		erreurAutoriserHBox.add(labelErreurAutoriser)
		erreurAutoriserHBox.add(switchErreurAutoriser)

		surlignageSurvolHbox = Gtk::Box.new(:horizontal,5)
		labelSurlignageSurvol = Gtk::Label.new("Avoir un surlignage des lignes et des colonnes")
		switchSurlignageSurvol = Gtk::Switch.new
		switchSurlignageSurvol.signal_connect('state-set') do
			surlignageSurvol = switchSurlignageSurvol.active?
			Serialisable.setSurlignageSurvol(surlignageSurvol)
			switchSurlignageSurvol.state = surlignageSurvol
		end
		surlignageSurvolHbox.add(labelSurlignageSurvol)
		surlignageSurvolHbox.add(switchSurlignageSurvol)

		vBox.add entry_username
		vBox.add bgHBox
		vBox.add scHBox
		vBox.add cchiffHbox
		vBox.add cSurlignHbox
		vBox.add erreurAutoriserHBox
		vBox.add surlignageSurvolHbox
		vBox.add menuButton
		self.add vBox

		show_all
	end
end

#`logname` 