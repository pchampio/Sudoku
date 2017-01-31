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


# === Solver d'une planche de Sudoku
# === Variables d'instance
# - +board+	  -> (*LECTURE*) La planche a résoudre (copie)<br>
# - +boxes+	  -> (*PRIVATE*) Hash des boxes dans la planche,
#                Les valeurs liée aux attributs sont des tableau conteneur des Cell,
#                Les cell on pour valeur un tableau des possibles case a cette coordonne<br>
# - +unusedCells+ -> Hash, clé: le num de la boxe,
# valeur: l'addition de toutes possibilités de valeurs dans les case de la boxe en question

class Solver

  # initialisation des conteneurs des valeurs possibles
  private def create_unknown
    # les possibles valeurs sur les boxes
    @boxes = {}
    @unknownInBoxes= {}

    @board.each_with_coord do |cell,i,j,box|

      # Met des tableaux dans le hashs
      @boxes[box] = [] if !@boxes.has_key?(box)
      @unknownInBoxes[box] = [] if !@unknownInBoxes.has_key?(box)

      cellValue = [0]# valeur default
      if @board.cellAt(i,j).vide?
        cellValue = @board.possibles(cell)
        @unknownInBoxes[box] += cellValue
      end

      caase = Cell.creer(i, j, box)
      caase.value = cellValue

      possibles = caase
      @boxes[box] << possibles
    end
  end

  def initialize(board)#:nodoc:
    @board = board.copie
    create_unknown
  end
  # Crée une copie du puzzle dans le but de résoudre cette planche
  # * *Arguments*    :
  #   - +board+  -> la planche a résoudre
  # * *Returns*
  #   - Solver
  def self.creer(board)
    new(board)
  end
  private_class_method :new

  attr_reader :board#:nodoc:

  # Complète les trous vide dans une planche (par essais,erreur)
  # * *Arguments*    :
  #   - +display+  -> true POUR DEBUG !! (anim résolution peut être long)
  # * *Returns*
  #   réussite?
  #   - true/false
  def solve(display=false)
    index = 0
    vacants = @board.unusedCells

    return false if vacants.empty?

    vacants.sort_by! { |v|  @board.possibles(v).length}

    while index > -1 and index < vacants.length
      current = vacants[index]
      flag = false
      # Pour toutes les valeurs suivantes
      (current.value+1..9).each do |num|
        # Possible ?
        if @board.possibles(current).include?(num)
          current.value = num
          flag = true
          break
        end
      end

      # Debug LONG
      if display
        system("clear;")
        print @board
        sleep 0.1
      end

      # Backtrack ?
      if not flag
        current.value = 0
        index -= 1
      else
        index += 1
      end

    end
    return index == vacants.length
  end


  # Complète les trous vide dans une planche (par logiqu naked Single http://www.sadmansoftware.com/sudoku/nakedsingle.php)
  # * *Returns*
  #   réussite?
  #   - true/false
  def solveLogic

    changement = true
    while changement
      changement = false

      # Pour toutes les Cells
      @boxes.each_with_index do |boxe,numBoxe|

        # Récupération de la Cell la plus moins répéter dans la boxe
        minRepeated_number = @unknownInBoxes[numBoxe].min_by{ |v| @unknownInBoxes[numBoxe].count(v)}
        minRepeated_count = @unknownInBoxes[numBoxe].count(minRepeated_number)

        boxe[1].each do |cell|
          # Si une Cell n'a qu'une possibilité alors on peut affecter la valeur à la planche
          if cell.value.length == 1 and cell.value.first != 0
            @board.cellAt(cell.row, cell.col).value = cell.value.first
            changement = true
          end
          # Si la Cell la moins répéter ne l'est qu'une fois alors c'est la seule possibilité
          if minRepeated_count == 1 and cell.value.include?(minRepeated_number)
            @board.cellAt(cell.row, cell.col).value = minRepeated_number
            changement = true
          end
        end
        if changement
          create_unknown
          break
        end
      end
    end

    # Si le solveLogic a trouver une solution
    @board.unusedCells.length == 0
  end

  # Afficher un Solver correspond a afficher la planche
  # * *Return*
  #   - une chaine de caractère qui reprisent la planche
  def to_s
    @board.to_s
  end
end
