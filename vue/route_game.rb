require 'gtk3'
require 'yaml'
require 'thread'


Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require_relative "../class/generator_class.rb"

class Game < Gtk::Overlay

  def initialize(window,board)
    super()

    # create headerbar
    HeadBar.create(window, "Sudoku","Groupe C")

    hBox = Gtk::Box.new(:horizontal,2)
    boardComponent = BoardComponent.create board
    inGameMedu = InGameMenu.create(boardComponent)

    hBox.add(boardComponent)
    hBox.add(inGameMedu)

    @backgroundColor = window.style_context.get_background_color "NORMAL"
    @backgroundColor  = Gdk::RGBA.new(@backgroundColor.red, @backgroundColor.green, @backgroundColor.blue, 0.93)

    init_overlay
    showOverlay

    vbox = Gtk::Box.new(:vertical, 10)
    vbox.halign = :center
    vbox.valign = :center
    button = Gtk::Button.new(:label =>"coucou")
    button.name = "buttontest"
    vbox.add button

    apply_css_color_button(button, "background", Serialisable.getBackgroundColor)
    button.signal_connect "clicked" do
      hideOverlay
    end

    addToOverlay vbox

    self.set_overlay_pass_through(@frame, false)
    self.add(hBox)
    css=<<-EOT
          #switchWrite {
            -GtkSwitch-slider-width: 45px;
            transition: all 200ms ease-in;
            border: none;
            border-radius: 14px;
            color: transparent;
          }
          #wind {
            background-color: #{@backgroundColor};
          }
    EOT
    apply_style(self, css)
  end

  def init_overlay
    @frame = Gtk::Frame.new
    @frame.name = "wind"
  end

  def hideOverlay
    self.remove(@frame)
  end

  def showOverlay
    self.add_overlay(@frame)
  end

  def addToOverlay box
    @frame.add box
  end

end
