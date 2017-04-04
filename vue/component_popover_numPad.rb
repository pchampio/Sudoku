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

        # NUMPAD
        numButtons.signal_connect("clicked")do
          if InGameMenu.mode_ecriture == :candidates
            @celluleComponent.possiblesAddDel(val)
          else
            @celluleComponent.set_value(val)
            @celluleComponent.hidePopover
            @board_comp.highlightCurrentNum(@celluleComponent)
            @board_comp.board.snapshot
            if @board_comp.board.complete?
              @board_comp.end_game
              @board_comp.updateBoardColor
            end
          end

          if InGameMenu.auto_maj_candidates
            @board_comp.showPossibles
          end
        end

      end
    end

    labelGomme = Gtk::Label.new("Gomme", :use_underline => true)
    imgGomme = Gtk::Image.new(:file => File.dirname(__FILE__) +"/../ressources/gomme.png", :size=>100)
    buttonGomme = Gtk::Button.new(:label=>nil,:use_underline => true)

    # GOMME
    buttonGomme.signal_connect("clicked")do
      if InGameMenu.mode_ecriture == :candidates
        @celluleComponent.delHints
      else
        @celluleComponent.set_value(0) # set numbre to none
        @celluleComponent.possiblesAddDel(0) # redraw possibles
        @celluleComponent.hidePopover
      end

      @board_comp.highlightCurrentNum(@celluleComponent)
      if InGameMenu.auto_maj_candidates
        @board_comp.showPossibles
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
    candidates = @board_comp.board.possibles(@celluleComponent.cell)
    @numButtons.each_with_index do |numbutton, index|
      if InGameMenu.mode_ecriture == :chiffre and not GlobalOpts.getErreurAutoriser
        numbutton.set_sensitive(candidates.include? index+1)
      else
        numbutton.set_sensitive(true)
      end
    end
  end

end

