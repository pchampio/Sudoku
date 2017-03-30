require 'gtk3'
require 'yaml'
require 'thread'


Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

class Game < Gtk::Frame

  def initialize(window,board)
    super()

    # create headerbar
    HeadBar.create(window, "Sudoku","Groupe C")

    hBox = Gtk::Box.new(:horizontal,2)
    boardComponent = BoardComponent.create board
    inGameMedu = InGameMenu.create(self, boardComponent)

    hBox.add(boardComponent)
    hBox.add(inGameMedu)
    self.add(hBox)
    css=<<-EOT
        #sw{
            slider-width : 40
        }
    EOT
    apply_style(self, css)
  end
end
