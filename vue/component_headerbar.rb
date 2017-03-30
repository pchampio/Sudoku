#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: DEZERE Florian
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require "gtk3"
require_relative './component_timer.rb'

class HeadBar

    private_class_method :new

    def self.create(main_window, title, subtitle)
        new(main_window, title, subtitle)
    end

    def initialize(main_window, title, subtitle)
        @title, @subtitle = title, subtitle

        @header = Gtk::HeaderBar.new
        @header.show_close_button = true
        @header.title = @title
        # @header.set_has_subtitle = true
        @header.subtitle = @subtitle

        @buttonSettings = Gtk::Button.new
        iconSettings = Gio::ThemedIcon.new("mail-send-receive-symbolic")
        imageSettings = Gtk::Image.new(:icon => iconSettings, :size => :button)
        @buttonSettings.add(imageSettings)
        @header.pack_end(@buttonSettings)

        @buttonSuivant = Gtk::Button.new
        imageSuivant = Gtk::Image.new(:icon_name => "pan-start-symbolic", :size => :button)
        @buttonSuivant.add(imageSuivant)
        @header.pack_start(@buttonSuivant)

        @buttonPrecedent = Gtk::Button.new
        imagePrecedent = Gtk::Image.new(:icon_name => "pan-end-symbolic", :size => :button)
        @buttonPrecedent.add(imagePrecedent)
        @header.pack_start(@buttonPrecedent)

        labelTime = Gtk::Label.new
        @time = Timer.create labelTime  #avec ça, on à accès aux méthodes pour avoir un bel affichage par exemple ! :)

        @buttonTime = Gtk::Button.new
        iconTime = Gio::ThemedIcon.new("alarm-symbolic.symbolic")
        imageTime = Gtk::Image.new(:icon => iconTime, :size => :button)
        @buttonTime.signal_connect("clicked") do
            puts "coucou"
            #afficher overlay pause
            #@time.pause #ne connait pas stoppe pour thread? normal? :/
            #une fois qu'on quitte la pause, faire un @time.run ==> du coup l'overlay pause aura besoin de la VI time non?
        end
        @buttonTime.add(imageTime)
        @header.pack_start(@buttonTime)
        @header.pack_start(labelTime)

        main_window.titlebar = @header
    end

    def setVisibleSettings(b)
        if b
            @header.pack_end(@buttonSettings)
        else
            @header.remove(@buttonSettings)
        end
    end

    def setVisibleSuivant(b)
        if b
            @header.pack_start(@buttonSuivant)
        else
            @header.remove(@buttonPrecedent)
        end
    end

    def setVisiblePrecedent(b)
        if b
            @header.pack_start(@buttonPrecedent)
        else
            @header.remove(@buttonPrecedent)
        end
    end

    def setVisibleTimer(b)
        if b
            @header.pack_start(@labelTime)
        else
            @header.remove(@labelTime)
        end
    end
end
