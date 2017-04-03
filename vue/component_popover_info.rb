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

class InfoPopover < Popover

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
    @label = Gtk::Label.new
    update
    self.add(@label)
    return self
  end

  def update
    left = 9 - @board_comp.board.sameCellsValue(@celluleComponent.cell).count
    if left <= 0

    @label.set_markup("<span >Vous les avez tous trouvé</span>")
    else
    @label.set_markup("<span > Il en reste #{
                      9-@board_comp.board.sameCellsValue(@celluleComponent.cell).count
                      } </span>")
    end
  end
end
