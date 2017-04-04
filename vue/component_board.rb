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

class BoardComponent < Gtk::Frame

  attr_reader :board # board de l'api ../class/board_class.rb

  private_class_method :new
  def self.create(board, main_game)
    new(board, main_game)
  end

  def initialize(board, main_game)
    super()

    @main_game = main_game
    @boardBoxView=Gtk::Table.new(3,3,true)

    initBoard(board)

    self.add(@boardBoxView)

    updateBoardColor
  end

  def initBoard(board)
    @board=board
    @board.snapshot

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

            boxView[x][y].attach(cell,i,i+1,j,j+1)
            @cellsView << cell

            cell.signal_connect("clicked") do
              highlightCurrentNum cell
            end

            cell.signal_connect("enter") do
              if GlobalOpts.getSurlignageSurvol
                highlightRowCol cell
              end
            end
          end
        end
        @boardBoxView.attach(boxView[x][y],x,x+1,y,y+1,nil,nil,3,3)

      end
    end
  end

  def highlightRowCol cellComp
    row = cellComp.cell.row
    col = cellComp.cell.col
    @cellsView.each do |cell|
      cell.change_style("background", GlobalOpts.getBackgroundColor)
      if row == cell.cell.row or col == cell.cell.col
        cell.change_style("background", GlobalOpts.getSurligneColor)
      end
    end
  end


  def end_game
    @main_game.end_game
  end

  def updateBoardColor
    @cellsView.each do |cell|
      cell.change_style("background", GlobalOpts.getBackgroundColor)
      cell.change_style("color", GlobalOpts.getChiffreColor)
    end
  end

  def updateBoard(board)
    updateBoardColor
    @board = board
    @board.snapshot
    @boardBoxView.children.each do |tab|
      tab.children.each do |cell|
        cell.init_ui(@board.cellAt(cell.cell.row,cell.cell.col), self)
      end
    end
  end

  def lazyupdateBoard(board)
    @board = board
    @boardBoxView.children.each do |tab|
      tab.children.each do |cell|
        current = @board.cellAt(cell.cell.row,cell.cell.col)
        if cell.cell != current
          cell.init_ui(current, self)
        else
          cell.updateCell current
        end
      end
    end
  end

  def highlightCurrentNum(cellComp)
    cellComp.change_style("background", GlobalOpts.getSelectColor)
    @cellsView.each do |cell|
      if  !cellComp.cell.vide? and cellComp.cell.value == cell.cell.value
        if cell!=cellComp
          cell.change_style("color", GlobalOpts.getSelectColor)
        end
      else
        cell.change_style("color", GlobalOpts.getChiffreColor)
      end
    end
  end

  def hideall
    @cellsView.each do |cell|
      cell.change_style("color", GlobalOpts.getBackgroundColor)
      cell.change_style("background", GlobalOpts.getBackgroundColor)
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
