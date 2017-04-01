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

    @boardBoxView=Gtk::Table.new(3,3,true)

    initBoard(board)

    self.add(@boardBoxView)

    updateBoardColor
  end

  def initBoard(board)
    @board=board

    # container of all CellComponent
    @cellsView = []

    boxView=Array.new(3){Array.new(3)}

    # creation des 9 boxes de la grille
    0.upto(2) do |y|
      0.upto(2) do |x|
        boxView[x][y]=Gtk::Table.new(3,3,true)

        # creation des 9 cases dans une boxe
        0.upto(2) do |i|
          0.upto(2) do |j|

            cell=CellComponent.create(@board.cellAt(y*3+j,x*3+i), self)

            # style
            cell.style_context.add_class("cell")
            cell.style_context.add_class("cell" + cell.cell.row.to_s + cell.cell.col.to_s)
            cell.style_context.add_class("row" + cell.cell.row.to_s)
            cell.style_context.add_class("col" + cell.cell.col.to_s)

            boxView[x][y].attach(cell,i,i+1,j,j+1)
            @cellsView << cell

            cell.signal_connect("clicked") do
              css=<<-EOF
              .cell#{cell.cell.row.to_s + cell.cell.col.to_s}{
                #{apply_css_convert_color("color", GlobalOpts.getChiffreColor)}
              }
              .cell{
                #{apply_css_convert_color("background-color", GlobalOpts.getBackgroundColor)}
              }
              .cell#{cell.cell.row.to_s + cell.cell.col.to_s}{
                #{apply_css_convert_color("background-color", GlobalOpts.getSelectColor)}
              }
              EOF
              highlightCurrentNum cell
              apply_style(cell, css)
            end

            cell.signal_connect("enter") do
              if GlobalOpts.getSurlignageSurvol
                css=<<-EOT
                .cell{
                  #{apply_css_convert_color("background-color", GlobalOpts.getBackgroundColor)}
                }
                .row#{cell.cell.row} {
                  #{apply_css_convert_color("background-color", GlobalOpts.getSurligneColor)}
                }
                .col#{cell.cell.col} {
                  #{apply_css_convert_color("background-color", GlobalOpts.getSurligneColor)}
                }
                EOT
                apply_style(cell, css)
              end
            end
          end
        end
        @boardBoxView.attach(boxView[x][y],x,x+1,y,y+1,nil,nil,3,3)

      end
    end
  end

  def updateBoardColor
    css=<<-EOT
    .cell{
      #{apply_css_convert_color("background-color", GlobalOpts.getBackgroundColor)}
      #{apply_css_convert_color("color", GlobalOpts.getChiffreColor)}
    }
    EOT
    apply_style(self, css)
  end

  def updateBoard(board)
    @board = board
    @boardBoxView.children.each do |tab|
      tab.children.each do |cell|
        cell.init_ui(@board.cellAt(cell.cell.row,cell.cell.col), self)
      end
    end
  end

  def highlightCurrentNum(cellComp)
    css=<<-EOT
    .cell{
      #{apply_css_convert_color("color", GlobalOpts.getChiffreColor)}
    }
    EOT
    apply_style(self, css)
    @cellsView.each do |cell|
      if  !cellComp.cell.vide? and cellComp.cell.value == cell.cell.value
        if cell!=cellComp
          apply_css_color_button(cell, "color", GlobalOpts.getSelectColor)
        end
      end
    end
  end

  def showPossibles
    unusedCells = @board.unusedCells
    @cellsView.each do |cellsview|
      if unusedCells.include? cellsview.cell
        cellsview.set_hints(
          @board.possibles(cellsview.cell)
        )
      end
    end
  end

  def hidePossibles
    unusedCells = @board.unusedCells
    @cellsView.each do |cellsview|
      if unusedCells.include? cellsview.cell
        cellsview.delHints
      end
    end
  end
end
