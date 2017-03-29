#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: CHAMPION Pierre
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

class CellComponent < Gtk::Button
  attr_reader :cell

  private_class_method :new

  def self.create(cell, board_comp)
    new(cell, board_comp)
  end

  def initialize(cell, board_comp)
    super()
    @cell=cell

    @label = Gtk::Label.new
    @label.wrap = false
    add(@label)

    @fontSize = 18

    @possibles = []
    set_value
    set_size_request(54, 54)
    apply_css_color_button(self, "background", Serialisable.getBackgroundColor)
    apply_css_color_button(self, "color", Serialisable.getChiffreColor)
    add_cell_with_popover(board_comp)
  end

  ######################################
  #  init/change label of cell button  #
  ######################################

  def set_value(v=@cell.value)
    if @cell.freeze?
      @label.set_markup("<span font='#{@fontSize}'><b>#{v}</b></span>")
      return
    end
    @cell.value=v
    if(v!=0)
      @label.set_markup("<span font='#{@fontSize}'>#{v}</span>")
    else
      @label.set_markup("")
    end
  end


  ###########################
  #  Creation d'un popover  #
  ###########################

  def create_popover(parent, child, pos)
    popover = Gtk::Popover.new(parent)
    popover.signal_connect "closed" do
      unless @cell.vide?
        apply_css_color_button(self, "color", Serialisable.getSelectColor)
      end
      apply_css_color_button(self, "background", Serialisable.getBackgroundColor)
    end
    popover.position = pos
    popover.add(child)
    child.margin = 5
    child.show_all
    popover
  end

  def createPopover(parent, pos, window)
    content = window.child
    content.parent.remove(content)
    window.destroy
    popover = create_popover(parent, content, pos)
    popover
  end

  def add_cell_with_popover(board_comp)
    if @cell.freeze?
      popoverWind = InfoPopover.create(self, board_comp.board)
    else
      popoverWind = NumPadPopover.create(self, board_comp)
    end
    entry_popover = createPopover(
      self, :top, popoverWind
    )
    self.signal_connect "clicked" do
      entry_popover.show
      popoverWind.update
    end
  end

  ############################
  #  Gestion des candidates  #
  ############################

  def set_hints(possibles)
    @possibles = possibles
    str = "<span  font='10'>"
    1.upto(9) do |v|
      str += "\n" if v == 4 or v == 7
      if possibles.include?(v)
        str += "<span >#{v} </span>"
      else
        str += "<span foreground='blue' alpha='1'>0 </span>"
      end
    end
    str += "</span>"
    @label.set_markup(str)
  end

  def delHints
    set_hints([])
  end

  def possiblesAddDel(i)
    if @possibles.include?(i)
      set_hints((@possibles - [i]))
    else
      set_hints((@possibles + [i]).uniq)
    end
    @cell.value = 0
  end

  def to_s
    return @cell.to_s
  end

end
