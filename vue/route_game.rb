require 'gtk3'

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require_relative "../class/generator_class.rb"

class Game < Gtk::Overlay

  attr_reader :header
  def initialize(window, board)
    super()
    SaveUser.load
    @window = window

    hBox = Gtk::Box.new(:horizontal,2)
    @boardComponent = BoardComponent.create board, self
    inGameMedu = InGameMenu.create(@boardComponent)

    # create headerbar
    @header = HeadBar.create(self, "Sudoku","Groupe C",@boardComponent)
    window.titlebar = @header
    hBox.add(@boardComponent)
    hBox.add(inGameMedu)

    @backgroundColor = window.style_context.get_background_color "NORMAL"
    @backgroundColor_blur  = Gdk::RGBA.new(@backgroundColor.red, @backgroundColor.green, @backgroundColor.blue, 0.75)
    @cursorWait = Gdk::Cursor.new("wait")
    @cursorDefault = Gdk::Cursor.new("default")

    init_overlay
    accueil = Accueil.new
    addToOverlay accueil
    showOverlay
    @header.time.raz
    @header.time.toggle

    accueil.signal_retour do
      @header.time.raz
      @header.time.toggle
      cleanOverlay
      hideOverlay
    end

    self.add(hBox)
  end

  def end_game
    cleanOverlay
    @header.time.toggle
    nbEtoile = 0
    nbEtoile += 1 if not @boardComponent.board.bUseSolution
    nbEtoile += 1 if not @boardComponent.board.bMakeError
    victory_ovly = OverlayVictory.new(
      nbEtoile, @header.time.elapse, @boardComponent.board.difficulty
    )
    addToOverlay victory_ovly
    showOverlay

    victory_ovly.signal_retour do
      @header.time.toggle
      cleanOverlay
      hideOverlay
      @header.new_game
    end
  end

  def init_overlay
    @boxContent = []
    @frame = Gtk::Frame.new
    @box = Gtk::Box.new(:horizontal, 10)
    @box.halign = :center
    @box.valign = :center
    @frame.add(@box)
    @frame.name = "overlay"
    @box.name = "menu"
    @visible = false
  end

  def hideOverlay
    self.remove(@frame) if @visible
    @visible = false
  end

  def showOverlay
    unless @visible
      @visible = true
      self.add_overlay(@frame)
      self.set_overlay_pass_through(@frame, false)
      self.show_all
      css=<<-EOT
          #overlay {
            background-color: #{@backgroundColor_blur};
          }
          #menu {
            background-color: #{@backgroundColor};
          }
      EOT
      apply_style(self, css)
    end
  end

  def addToOverlay box
    @boxContent <<  box
    @box.add box
  end

  def cleanOverlay
    @boxContent.each do |content|
      @box.remove(content)
    end
    @boxContent = []
  end

  def isOverlayVisible?
    return @visible
  end

  def raz_cursor
    @window.window.set_cursor @cursorDefault
  end

  def load_cursor
    @window.window.set_cursor @cursorWait
  end

end
