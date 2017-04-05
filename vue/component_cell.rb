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

    @resetModeEcriture = nil

    @label = Gtk::Label.new
    @label.wrap = false
    add(@label)

    @fontSize = 18
    set_size_request(54, 54)

    init_ui(cell, board_comp)
    @board_comp = board_comp


  end

  def init_ui(cell, board_comp)
    @cell=cell
    @possibles = cell.possibles
    set_value
    add_cell_with_popover(board_comp)
    possiblesAddDel(0) if @cell.value == 0
  end

  def updateCell cell
    @cell = cell
  end

  def change_style(target, color)
    css=<<-EOT
    button{
      #{apply_css_convert_color(target, color)}
    }
    EOT
    css_provider = Gtk::CssProvider.new
    css_provider.load :data=>css
    self.style_context.add_provider css_provider, Gtk::StyleProvider::PRIORITY_USER
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

  def createPopover(parent, pos, window)
    content = window.child
    content.parent.remove(content)
    @popover = Gtk::Popover.new(parent)
    @popover.signal_connect "closed" do
      if(@resetModeEcriture)
        InGameMenu.mode_ecriture = @resetModeEcriture
        @resetModeEcriture = nil
      end
      @board_comp.updateBoardColor
      @board_comp.highlightCurrentNum self

      unless @cell.vide?
        self.change_style("color", GlobalOpts.getSelectColor)
      end
    end
    @popover.position = pos
    @popover.add(content)
    content.margin = 5
    content.show_all
    @popover

  end

  def button_press(event)
    oldMode = InGameMenu.mode_ecriture
    if (event.button == 3)
      InGameMenu.mode_ecriture = :candidates
    end
    if (event.button == 1) and oldMode == :chiffre
      InGameMenu.mode_ecriture = :chiffre
    end
    if(InGameMenu.mode_ecriture != oldMode)
      @resetModeEcriture = oldMode
    end
  end

  def add_cell_with_popover(board_comp)
    if @cell.freeze?
      @popoverWind = InfoPopover.create(self, board_comp)
    else
      @popoverWind = NumPadPopover.create(self, board_comp)
    end
    createPopover(self, :top, @popoverWind)
    self.signal_connect("button_press_event") {
      |_widget, event, _y|
      button_press( event)
      self.change_style("color", GlobalOpts.getChiffreColor)
      @popoverWind.update
      @popover.show
      self.clicked #send clicked to parent
    }
  end

  def hidePopover
    @popover.visible = false
  end

  def showPopover
    @popoverWind.update
    @popover.visible = true
  end

  ############################
  #  Gestion des candidates  #
  ############################

  def set_hints(possibles)
    @possibles = possibles
    @cell.possibles = @possibles.dup
    str = "<span  font='10'>"
    1.upto(9) do |v|
      str += "\n" if v == 4 or v == 7
      if @possibles.include?(v)
        str += "<span font-family='monospace'>#{v}</span>"
        str += "<span> </span>"
      else
        str += "<span font-family='monospace'> </span>"
        str += "<span> </span>"
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
      possibles = @possibles - [i]
      set_hints(possibles)
    else
      possibles = (@possibles + [i]).uniq
      set_hints(possibles)
    end
    @cell.value = 0
  end

  def to_s
    return @cell.to_s
  end

end

