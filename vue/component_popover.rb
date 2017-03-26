#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: CHAMPION Pierre
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'

class Popover < Gtk::Window

  private_class_method :new

  def initialize
    super(:toplevel)
  end

  def init_ui
  end

  def update
  end
end
