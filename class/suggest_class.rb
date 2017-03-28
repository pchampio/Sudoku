#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: CHAMPION Pierre
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

#:nodoc:
require_relative './board_class.rb'

class Suggest

  attr_reader :board#:nodoc:

  def initialize(board)
    @hintLenth = 0
    @board = board
    create_unknown
  end

  def self.creer(board)
    new(board)
  end
  private_class_method :new


  # initialisation des conteneurs des valeurs possibles
  private def create_unknown
    # les possibles valeurs sur les boxes
    @boxes = {}
    @unknownInBoxes= {}

    @board.each_with_coord do |cell,i,j,box|

      # Met des tableaux dans le hashs
      @boxes[box] = [] if !@boxes.has_key?(box)
      @unknownInBoxes[box] = [] if !@unknownInBoxes.has_key?(box)

      possibles = []
      if @board.cellAt(i,j).vide?
        possibles = @board.possibles(cell)
        @unknownInBoxes[box] += possibles
      end

      caase = Cell.creer(i, j, box)
      caase.possibles = possibles

      @boxes[box] << caase
    end
  end


  def hiddenSingle
    @boxes.each_with_index do |boxe,numBoxe|

      # Récupération de la Cell la plus moins répéter dans la boxe
      minRepeated_number = @unknownInBoxes[numBoxe].min_by{ |v| @unknownInBoxes[numBoxe].count(v)}
      minRepeated_count = @unknownInBoxes[numBoxe].count(minRepeated_number)

      boxe[1].each do |cell|
        # Si une Cell n'a qu'une possibilité alors on peut affecter la valeur à la planche
        # Si la Cell la moins répéter ne l'est qu'une fois alors c'est la seule possibilité
        if cell.possibles.length == 1 and !cell.possibles.empty? \
            or minRepeated_count == 1 and cell.possibles.include?(minRepeated_number)
          puts "Examine the digit #{cell.possibles.first}."
          puts "Where in block #{cell.box+1} can you put a #{cell.possibles.first}?"
          puts "Only R#{cell.row+1}C#{cell.col+1} can be #{cell.possibles.first}."
          return
        end
      end
    end
  end

end
