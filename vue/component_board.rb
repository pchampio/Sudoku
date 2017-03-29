#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: Waibin Wang, Riviere Marius, Pierre Champion
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

##class héritant de Gtk::Frame
#permet d'être ajoutée dans une fenêtre
class BoardComponent < Gtk::Frame

  attr_reader :board # board de l'api ../class/board_class.rb

  private_class_method :new
  def self.create(board)
    new(board)
  end

  def initialize(board)
    super()
    @board=board

    # vues
    @boardBoxView=Gtk::Table.new(3,3,true)
    @boxView=Array.new(3){Array.new(3)}

    # container of all CellComponent
    @cellsView = []

    # creation des 9 boxes de la grille
    0.upto(2) do |y|
      0.upto(2) do |x|
        @boxView[x][y]=Gtk::Table.new(3,3,true)

        # creation des 9 cases dans une boxe
        0.upto(2) do |i|
          0.upto(2) do |j|

            cell=CellComponent.create(@board.cellAt(x*3+i,y*3+j), self)
            @boxView[x][y].attach(cell,i,i+1,j,j+1)
            @cellsView << cell

            cell.signal_connect("clicked") do
              apply_css_color_button(cell, "background", Serialisable.getSelectColor)
              highlightCurrentNum(cell)
            end

          end
        end
        tmp = Gtk::Frame.new()
        tmp.add(@boxView[x][y])
        @boardBoxView.attach(tmp,x,x+1,y,y+1,nil,nil,3,3)

      end
    end
    self.add(@boardBoxView)
  end

  def highlightCurrentNum(cellComp)
    @cellsView.each do |cell|
      if  !cellComp.cell.vide? and cellComp.cell.value == cell.cell.value
        if cell!=cellComp
          apply_css_color_button(cell, "color", Serialisable.getSelectColor)
        end
      else
        apply_css_color_button(cell, "color", Serialisable.getChiffreColor)
      end
    end
  end

  def affichePossiblite()
    unusedCells = @board.unusedCells
    @cellsView.each do |cellsview|
      if unusedCells.include? cellsview.cell
        cellsview.set_hints(
          @board.possibles(cellsview.cell)
        )
      end
    end
  end

  def deletePossibilite
    unusedCells = @board.unusedCells
    @cellsView.each do |cellsview|
      if unusedCells.include? cellsview.cell
        cellsview.delHints
      end
    end
  end
end
