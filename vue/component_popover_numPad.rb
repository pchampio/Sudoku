#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: CHAMPION Pierre
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'

require_relative './component_popover.rb'

class NumPadPopover < Popover
  private_class_method :new
  def self.create(cellComponent, board_comp)
    new(cellComponent, board_comp)
  end

  def initialize(cellComponent, board_comp)
    super()
    @celluleComponent = cellComponent
    @board_comp = board_comp
    self.show
    return init_ui
  end

  def init_ui
    vBox = Gtk::Box.new(:vertical,2)
    table = Gtk::Table.new(3,3,true)

    @numButtons = []

    0.upto(2) do |y|
      0.upto(2) do |x|

        val=x+y*3+1
        numButtons = Gtk::Button.new
        @numButtons << numButtons
        label = Gtk::Label.new
        label.set_markup("<span font='18' ><b>#{val}</b></span>")

        numButtons.add(label)
        numButtons.set_size_request(40, 40)
        table.attach(numButtons,2*x,2*(x+1),y,(y+1))

        numButtons.signal_connect("clicked")do
          if InGameMenu.mode_ecriture == :candidates
            @celluleComponent.possiblesAddDel(val)
          else
            @celluleComponent.set_value(val)
          end
          @board_comp.highlightCurrentNum(@celluleComponent)
          if InGameMenu.audo_maj_candidates
            @board_comp.affichePossiblite
          end
        end

      end
    end

    labelGomme = Gtk::Label.new("Gomme", :use_underline => true)
    imgGomme = Gtk::Image.new(:file => File.dirname(__FILE__) +"/../ressources/gomme.png", :size=>100)
    buttonGomme = Gtk::Button.new(:label=>nil,:use_underline => true)

    buttonGomme.signal_connect("clicked")do
      @celluleComponent.set_value(0)
      @celluleComponent.delHints
      @board_comp.highlightCurrentNum(@celluleComponent)
      if InGameMenu.audo_maj_candidates
        @board_comp.affichePossiblite
      end
    end

    boxGomme = Gtk::Box.new(:horizontal,2)
    boxGomme.add(imgGomme)
    boxGomme.add(labelGomme)
    buttonGomme.add(boxGomme)

    vBox.add(table)
    vBox.add(buttonGomme)
    self.add(vBox)
    return self
  end

  def update
    # TODO Option dans Serialisable pour possible add numbre totalement faux
    candidates = @board_comp.board.possibles(@celluleComponent.cell)
    @numButtons.each_with_index do |numbutton, index|
      numbutton.set_sensitive(candidates.include? index+1)
    end
  end

end
