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

class HeadBar < Gtk::HeaderBar

    attr_reader :time

    private_class_method :new
    def self.create(overlay, title, subtitle, compboard)
        new(overlay, title, subtitle, compboard)
    end

    def initialize(overlay, title, subtitle, compboard)
        super()

        @overlay = overlay
        @compboard = compboard

        title, subtitle = title, subtitle
        self.show_close_button = true
        self.title = title
        self.subtitle = subtitle
        self.signal_connect("destroy") do
            compboard.board.time = @time.elapse
            compboard.board.serialized(File.dirname(__FILE__) + "/../save_board.yaml")
            SaveUser.serialized
        end

        labelTime = Gtk::Label.new
        time = Timer.create labelTime
        @time = time

        buttonSettings = Gtk::Button.new
        iconSettings = Gio::ThemedIcon.new("emblem-system-symbolic")
        imageSettings = Gtk::Image.new(:icon => iconSettings, :size => :button)
        buttonSettings.add(imageSettings)
        buttonSettings.signal_connect "clicked" do
          unless overlay.isOverlayVisible?
            time.toggle
            overlay.cleanOverlay
            option = Option.new
            overlay.addToOverlay option
            overlay.showOverlay

            option.signal_retour do
              time.toggle
              overlay.hideOverlay
              compboard.updateBoardColor
            end
          end
        end
        self.pack_end(buttonSettings)

        btnNewGame = Gtk::Button.new
        iconNewGame = Gio::ThemedIcon.new("document-new-symbolic")
        imageNewGame = Gtk::Image.new(:icon => iconNewGame, :size => :button)
        btnNewGame.add(imageNewGame)
        btnNewGame.signal_connect "clicked" do
          self.new_game("newnew")
        end
        self.pack_end(btnNewGame)

        # buttonSave = Gtk::Button.new
        # iconSave = Gio::ThemedIcon.new("document-save-symbolic")
        # imageSave = Gtk::Image.new(:icon => iconSave, :size => :button)
        # buttonSave.signal_connect("clicked") do
        #     compboard.board.serialized(File.dirname(__FILE__) + "/../save_board.yaml")
        #     SaveUser.serialized
        # end
        # buttonSave.add(imageSave)
        # self.pack_end(buttonSave)

        buttonOpen = Gtk::Button.new
        iconOpen = Gio::ThemedIcon.new("document-open-symbolic")
        imageOpen = Gtk::Image.new(:icon => iconOpen, :size => :button)
        buttonOpen.signal_connect("clicked") do
          boardSave = Board.unserialized(File.dirname(__FILE__) + "/../save_board.yaml")
          @time.elapse = boardSave.time
          compboard.updateBoard boardSave
        end
        buttonOpen.add(imageOpen)
        self.pack_end(buttonOpen)

        btnUndo = Gtk::Button.new
        imageSuivant = Gtk::Image.new(:icon_name => "edit-undo-symbolic", :size => :button)
        btnUndo.add(imageSuivant)
        btnUndo.signal_connect "clicked" do
          oldBoard = compboard.board.retrive_undo
          compboard.lazyupdateBoard oldBoard
        end
        self.pack_start(btnUndo)

        btnRedo = Gtk::Button.new
        imagePrecedent = Gtk::Image.new(:icon_name => "edit-redo-symbolic", :size => :button)
        btnRedo.add(imagePrecedent)
        btnRedo.signal_connect "clicked" do
          oldBoard = compboard.board.retrive_redo
          compboard.lazyupdateBoard oldBoard
        end
        self.pack_start(btnRedo)

        buttonTime = Gtk::Button.new
        iconTime = Gio::ThemedIcon.new("document-open-recent-symbolic")
        imageTime = Gtk::Image.new(:icon => iconTime, :size => :button)
        buttonTime.signal_connect("clicked") do
          time.toggle
          if time.running
            overlay.cleanOverlay
            pause = PA.create("pause")
            overlay.addToOverlay pause
            overlay.showOverlay
            pause.signal_retour do
              time.toggle
              overlay.hideOverlay
              compboard.updateBoardColor
            end
            # label = Gtk::Label.new("<span weight='ultrabold' font='40'>Pause</span>")
            # label.use_markup = true
            # overlay.addToOverlay label
            overlay.showOverlay
            compboard.hideall
          else
            compboard.updateBoardColor
            overlay.hideOverlay
          end
        end

        boxTime = Gtk::Box.new(:horizontal,4)
        boxTime.add(imageTime)
        boxTime.add(labelTime)
        buttonTime.add(boxTime)
        self.pack_start(buttonTime)

    end

    def new_game(param)
          unless @overlay.isOverlayVisible?
            @time.toggle
            if param == "newnew"
                newgame = NewGame.create param
            else
                newgame = NewGame.create param
            end
            @overlay.cleanOverlay
            @overlay.addToOverlay newgame
            @overlay.showOverlay

            newgame.signal_retour do
              if newgame.board
                @compboard.updateBoard newgame.board
                @time.elapse = newgame.board.time
              end
              @time.toggle
              @overlay.cleanOverlay
              @overlay.hideOverlay
              @overlay.raz_cursor
            end
          end
    end
end
