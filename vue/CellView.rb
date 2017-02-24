#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: Waibin Wang et Riviere Marius
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'
require_relative '../class/cell_class.rb'
##class CellView héritant (pour l'instant) de la classe Button
class CellView < Gtk::Button
  ##choix à faire : button, frame or widget ?

  ##variables
  attr_accessor :button #c'est le bouton que renvoie la class CellView en guise de case
  attr_accessor :cell #c'est la case de cell_class.rb
  #attr_accessor :state #peut-être vide, donnée, rempli
  ##constructeur
  #param cell : case de la grille de sudoku
  def initialize(cell)

    super()
    @cell=cell
    @label = Gtk::Label.new
    @label.wrap = false
    @label.width_chars = 7

    if(@cell.value==0)
      @label.set_markup("\n\n")
      self.add(@label)
    else
      @label.set_markup("<span size=\"larger\"><b>#{@cell.value}</b></span>")
      self.add(@label)
    end
  end

  def set_hints(possibles)
    # Monospace Fonts !!!!
    @possibles = possibles
    str = "<small>"
    1.upto(9) do |v|
      str += "\n" if v == 4 or v == 7
      if possibles.include?(v)
        # https://developer.gnome.org/pango/stable/PangoMarkupFormat.html
        str += "<span  font_family=\"Lucida Console\" color=\"red\" background=\"#757779\">#{v}</span>" if v == 1
        # c'est moche mais c'est pour la demo
        str += "<span font_family=\"Lucida Console\" >#{v}</span>" if v != 1

      else
        str += "<span font_family=\"Lucida Console\">#{" "}</span>"
      end
      str += "<span >#{" "}</span>"
    end
    str += "</small>"
    @label.set_markup(str)
  end

  def addPossible(i)
    set_hints((@possibles + [i]).uniq)
  end

  def delPossible(i)
    set_hints((@possibles - [i]))
  end

  def set_value(v)
    @label.set_markup("<big>#{v}</big>")
  end
end
