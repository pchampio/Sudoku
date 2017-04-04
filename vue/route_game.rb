require 'gtk3'

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require_relative "../class/generator_class.rb"

class Game < Gtk::Overlay

  def initialize(window, board)
    super()

    @window = window

    hBox = Gtk::Box.new(:horizontal,2)
    boardComponent = BoardComponent.create board
    inGameMedu = InGameMenu.create(boardComponent)

    self.signal_connect("destroy") do
      boardComponent.board.serialized("board_save.yml")
    end

    # create headerbar
    header = HeadBar.create(self, "Sudoku","Groupe C",boardComponent)
    window.titlebar = header
    hBox.add(boardComponent)
    hBox.add(inGameMedu)

    @backgroundColor = window.style_context.get_background_color "NORMAL"
    @backgroundColor_blur  = Gdk::RGBA.new(@backgroundColor.red, @backgroundColor.green, @backgroundColor.blue, 0.75)
    @cursorWait = Gdk::Cursor.new("wait")
    @cursorDefault = Gdk::Cursor.new("default")

    init_overlay
    # addToOverlay OverlayVictory.new 2,3,:easy
    # showOverlay

    self.add(hBox)
    # -GtkSwitch-slider-width: 45px;
    css=<<-EOT
          #switchWrite {
            transition: all 200ms ease-in;
            border: none;
            border-radius: 14px;
            color: transparent;
          }
    EOT
    apply_style(self, css)
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
