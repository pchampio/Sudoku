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

  @@test = 0
  private_class_method :new
  def self.create(cellComponent, board)
    new(cellComponent, board)
  end

  def initialize(cellComponent, board)
    super()
    @celluleComponent = cellComponent
    @board = board
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
    left = 9 - @board.sameCellsValue(@celluleComponent.cell).count
    if left <= 0

    @label.set_markup("<span >Vous les avez tous trouvé</span>")
    else
    @label.set_markup("<span > Il en reste #{
                      9-@board.sameCellsValue(@celluleComponent.cell).count
                      } </span>")
    end
  end
end
