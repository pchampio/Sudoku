#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: DEZERE Florian
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'
require_relative './globalOpts.rb'

class Option < Gtk::Frame

  def initialize()#:nodoc:
    super()
    vBox = Gtk::Box.new(:vertical,10)

    separator = Gtk::Label.new "", :use_underline => true, :xalign=>0
    separator1 = Gtk::Label.new "", :use_underline => true, :xalign=>0
    separator2 = Gtk::Label.new "", :use_underline => true, :xalign=>0
    separator3 = Gtk::Label.new "", :use_underline => true, :xalign=>0
    separator4 = Gtk::Label.new "", :use_underline => true, :xalign=>0
    separator5 = Gtk::Label.new "", :use_underline => true, :xalign=>0
    separator6 = Gtk::Label.new "", :use_underline => true, :xalign=>0

    scpicker = Gtk::ColorButton.new(GlobalOpts.getSelectColor)
    bgpicker = Gtk::ColorButton.new(GlobalOpts.getBackgroundColor)
    cpicker = Gtk::ColorButton.new(GlobalOpts.getChiffreColor)
    surlignepicker = Gtk::ColorButton.new(GlobalOpts.getSurligneColor)

    bgHBox = Gtk::Box.new(:horizontal,3)
    label_background = Gtk::Label.new "Couleur du fond de la grille :", :use_underline => true, :xalign=>0
    bgpicker.signal_connect("color-set"){
      GlobalOpts.setBackgroundColor(bgpicker.color)
    }

    bgHBox.pack_start(label_background, :expand=>false, :fill=>true, :padding=>15)
    bgHBox.pack_start(separator, :expand=>true, :fill=>true, :padding=>0)
    bgHBox.pack_start(bgpicker, :expand=>false, :fill=>true, :padding=>15)


    scHBox = Gtk::Box.new(:horizontal,3)
    label_selected_cell = Gtk::Label.new "Couleur de la case selectionnée :", :use_underline => true, :xalign=>0
    scpicker.signal_connect("color-set"){
      GlobalOpts.setSelectColor(scpicker.color)
    }

    scHBox.pack_start(label_selected_cell, :expand=>false, :fill=>true, :padding=>15)
    scHBox.pack_start(separator1, :expand=>true, :fill=>true, :padding=>0)
    scHBox.pack_start(scpicker, :expand=>false, :fill=>true, :padding=>15)


    cchiffHbox = Gtk::Box.new(:horizontal,3)
    label_num_color = Gtk::Label.new "Couleur des chiffres :", :use_underline => true, :xalign=>0
    cpicker.signal_connect("color-set"){
      GlobalOpts.setChiffreColor(cpicker.color)
    }
    cchiffHbox.pack_start(label_num_color, :expand=>false, :fill=>true, :padding=>15)
    cchiffHbox.pack_start(separator2, :expand=>true, :fill=>true, :padding=>0)
    cchiffHbox.pack_start(cpicker, :expand=>false, :fill=>true, :padding=>15)

    cSurlignHbox = Gtk::Box.new(:horizontal, 3)
    label_surligne_color = Gtk::Label.new "Couleur de surlignage :", :use_underline => true, :xalign=>0
    surlignepicker.signal_connect("color-set"){
      GlobalOpts.setSurligneColor(surlignepicker.color)
    }

    cSurlignHbox.pack_start(label_surligne_color, :expand=>false, :fill=>true, :padding=>15)
    cSurlignHbox.pack_start(separator3, :expand=>true, :fill=>true, :padding=>0)
    cSurlignHbox.pack_start(surlignepicker, :expand=>false, :fill=>true, :padding=>15)

    entrybuffUsername = Gtk::EntryBuffer.new(SaveUser.getUsername)
    @entry_username = Gtk::Entry.new entrybuffUsername
    @entry_username.set_max_length(15)
    labelUsername = Gtk::Label.new("Nom du joueur ", :use_underline=>true, :xalign=>0)
    usernameHbox = Gtk::Box.new(:horizontal, 3)
    usernameHbox.pack_start(labelUsername, :expand=>false, :padding=>15)
    usernameHbox.pack_start(separator4, :expand=>true, :fill=>true, :padding=>0)
    usernameHbox.pack_start(@entry_username, :expand=>false, :padding=>15)

    @menuButton=Gtk::Button.new(:label=>"Retour")
    @menuButton.signal_connect("clicked"){
      SaveUser.setUsername(@entry_username.text)
      GlobalOpts.serialized
    }
    @menuButton.style_context.add_class('suggested-action')

    #faire hbox pour avoir switch avec champs texte comme dans component in game menu
    erreurAutoriserHBox = Gtk::Box.new(:horizontal,15)
    labelErreurAutoriser = Gtk::Label.new("Autorisation des erreurs", :xalign=>0)
    switchErreurAutoriser = Gtk::Switch.new
    # erreurAutoriserHBox.set_homogeneous("r")

    switchErreurAutoriser.state = GlobalOpts.getErreurAutoriser

    switchErreurAutoriser.signal_connect('state-set') do
      #hasMakeError
      erreurAutoriser = switchErreurAutoriser.active?
      GlobalOpts.setErreurAutoriser(erreurAutoriser)
      switchErreurAutoriser.state = erreurAutoriser
    end
    erreurAutoriserHBox.pack_start(labelErreurAutoriser, :expand=>false, :fill=>true, :padding=>15)
    erreurAutoriserHBox.pack_start(separator5, :expand=>true, :fill=>true, :padding=>0)
    erreurAutoriserHBox.pack_start(switchErreurAutoriser, :expand=>false, :fill=>true, :padding=>15)

    surlignageSurvolHbox = Gtk::Box.new(:horizontal,15)
    labelSurlignageSurvol = Gtk::Label.new("Surlignage des lignes et des colonnes", :xalign=>0)
    switchSurlignageSurvol = Gtk::Switch.new
    # surlignageSurvolHbox.set_homogeneous("r")

    switchSurlignageSurvol.state = GlobalOpts.getSurlignageSurvol

    switchSurlignageSurvol.signal_connect('state-set') do
      surlignageSurvol = switchSurlignageSurvol.active?
      GlobalOpts.setSurlignageSurvol(surlignageSurvol)
      switchSurlignageSurvol.state = surlignageSurvol
    end
    surlignageSurvolHbox.pack_start(labelSurlignageSurvol, :expand=>false, :fill=>true, :padding=>15)
    surlignageSurvolHbox.pack_start(separator6, :expand=>true, :fill=>true, :padding=>0)
    surlignageSurvolHbox.pack_start(switchSurlignageSurvol, :expand=>false, :fill=>true, :padding=>15)

    title = Gtk::Label.new("<span weight='ultrabold' font='16'>Options</span>", :xalign=>0)
    title.use_markup = true

    vBox.pack_start(title, :expand=>false, :fill=>false, :padding=>15)
    vBox.pack_start(bgHBox, :expand=>false, :fill=>false, :padding=>2)
    vBox.pack_start(scHBox, :expand=>false, :fill=>false, :padding=>2)
    vBox.pack_start(cchiffHbox, :expand=>false, :fill=>false, :padding=>2)
    vBox.pack_start(cSurlignHbox, :expand=>false, :fill=>false, :padding=>2)
    vBox.pack_start(erreurAutoriserHBox, :expand=>false, :fill=>false, :padding=>2)
    vBox.pack_start(surlignageSurvolHbox, :expand=>false, :fill=>false, :padding=>2)
    vBox.pack_start(usernameHbox, :expand=>false, :fill=>false, :padding=>0)
    vBox.pack_start(@menuButton, :expand=>false, :fill=>false, :padding=>15)

    hBox = Gtk::Box.new(:horizontal, 10)
    hBox.pack_start(vBox, :expand=>false, :fill=>false, :padding=>15)
    self.add hBox
  end

  def signal_retour
    @menuButton.signal_connect("clicked") do
      yield
    end
  end
end
