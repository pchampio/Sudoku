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
require_relative './solver_class.rb'

# === Génération aléatoire d'une planche de Sudoku
# === Variables d'instance
# - +board+	  -> (*LECTURE*) La planche a générer<br>
# === Variables de class
# - +planche_base+	  -> La planche valide qui engendra d'autre planche par changement de lignes et colonnes
#
#    @@planche_base="
#      5 3 4   6 7 8   9 1 2
#      6 7 2   1 9 5   3 4 8
#      1 9 8   3 4 2   5 6 7
#
#      8 5 9   7 6 1   4 2 3
#      4 2 6   8 5 3   7 9 1
#      7 1 3   9 2 4   8 5 6
#
#      9 6 1   5 3 7   2 8 4
#      2 8 7   4 1 9   6 3 5
#      3 4 5   2 8 6   1 7 9
#    "
#
# - +difficulties+	  -> Rapport du nombre d'iterations a effectuer pour melanger une planche, {:easy, :medium, :hard, :extreme}
#     @@difficulties = {
#       :easy => [35,0],
#       :medium => [81,7],
#       :hard => [81,13],
#       :extreme => [81, 81]
#     }
#

class Generator

  @@planche_base="
    5 3 4   6 7 8   9 1 2
    6 7 2   1 9 5   3 4 8
    1 9 8   3 4 2   5 6 7

    8 5 9   7 6 1   4 2 3
    4 2 6   8 5 3   7 9 1
    7 1 3   9 2 4   8 5 6

    9 6 1   5 3 7   2 8 4
    2 8 7   4 1 9   6 3 5
    3 4 5   2 8 6   1 7 9
 "

  @@difficulties = {
    :easy => [35,0],
    :medium => [81,7],
    :hard => [81,13],
    # :extreme => [81, 81],
    :extreme => [1, 0],
    :full => [0,0]
  }

  # Creation d'une planche de base valide egal a @@planche_base
  def initialize
    @board = Board.creer(@@planche_base
      .delete("\s|\n").split("").reverse.map(&:to_i))
  end


  attr_reader :board#:nodoc:

  # Permet de mélanger la planche en permutant les lignes, colonnes, lignes de boxes, colonnes de boxes
  # * *Arguments*    :
  #   - +iterations+  -> le nombre de permutation
  # * *Returns*
  #   - Generator
  def randomize(iterations=50)
    # Le puzzle doit etre complet !!
    raise "The borad must be complete" if @board.usedCells.length != 81

    iterations.times do

      # random colonne, ligne (random un tableau et on prend les 2 premier indice)
      set = (0..2).to_a
      set.shuffle!
      index1, index2 = set[0], set[1]

      # random band, stack
      box = rand(0..2) * 3

      # action a faire pour mélanger
      case rand(0..3)
      when 0
        @board.swapRow(box + index1, box + index2)
      when 1
        @board.swapColumns(box + index1, box + index2)
      when 2
        @board.swapBand(index1, index2)
      when 3
        @board.swapStack(index1, index2)
      end
    end
    return self
  end

  # Méthode qui obtient toutes les valeurs possibles pour une cellule particulière, s'il n'y a qu'une seul<br>
  # Alors nous pouvons enlever cette cellule de la planche
  # * *Arguments*    :
  #   - +board+  -> la planche a réduire
  #   - +iterations+  -> le nombre de max de cellule a enlever
  # * *Returns*
  #   - Board
  def self.reduceLogic!(board, iterations=81)
    usedCells = board.usedCells
    usedCells.shuffle!

    for cell in usedCells
      break if iterations <= 0
      if board.possibles(cell).length == 1
        cell.value = 0
        iterations -= 1
      end
    end
    return board
  end


  # Méthode qui essaye de enlever des cellules.<br>
  # si la cellule enlever ne génère qu'une solution au Sudoku alors on peut la supprimer.<br> <br>
  # *Peut* être *lent* !!! (car beaucoup de tentative de résolution de Sudoku (elle vont jusqu'au bout sans rien trouver))
  # * *Arguments*    :
  #   - +board+  -> la planche a réduire
  #   - +iterations+  -> le nombre de max de cellule a enlever
  # * *Returns*
  #   - Board
  def self.reduireBrut!(board, iterations=0)
    return board if iterations <= 0
    usedCells = board.usedCells

    # Tris les cases par leurs fréquence d'apparition dans la planche
    # Permet d'homogénéiser la planche (ce qui la rend plus dure)
    usedCells.sort_by!{|v| -board.sameCellsValue(v).length}
    # usedCells.sort_by!{|v| -board.possibles(v).length}

    # usedCells.each do |usedcell|
    # print "#{board.sameCellsValue(usedcell).length} #{usedcell}\n"
    # end

    usedCells.each do |usedcell|
      original = usedcell.value

      # autres valeurs possibles sur cette case
      complement = (1..9).to_a - [original] - board.excluded(usedcell)
      ambiguous = false

      # si pour chaque valeur complémentaire le puzzle n'est pas solvable
      # Suppression de la case
      complement.each do |v|

        usedcell.value = v

        # Crée une instance Solver
        solver = Solver.creer(board)
        if solver.solveLogic
          # Le puzzle est ambigüe si l'on supprime cette case
          usedcell.value = original
          ambiguous = true
          break
        end

      end

      # si le puzzle n'est pas ambigüe
      # alors on peur supprimer cette case
      if not ambiguous
        usedcell.value = 0
        iterations -= 1
        solver = Solver.creer(board)
        if not solver.solveLogic
          usedcell.value = original
          solver = Solver.creer(board)
          solver.solveLogic
        end

        return board if iterations <= 0
      end
    end
    board
  end

  # Permet de supprimer des cases d'une planche en fonction d'un niveau
  #    :easy, :medium, :hard, :extreme
  # * *Arguments*    :
  #   - +board+  -> la planche a réduire
  #   - +level+  -> le niveau de la planche
  # * *Returns*
  #   - Board
  def self.reduce(board, level=:medium)
    difficulty = @@difficulties[level]
    reduceLogic!(board,difficulty[0])
    reduireBrut!(board,difficulty[1])
    board.freeze
  end

  # Permet de supprimer des cases d'une planche en fonction d'un niveau
  #    :easy, :medium, :hard, :extreme
  # * *Arguments*    :
  #   - +level+  -> le niveau de la planche
  # * *Returns*
  #   - Board
  def generate(level=:medium)
    self.randomize
    difficulty = @@difficulties[level]
    Generator.reduceLogic!(@board,difficulty[0])
    Generator.reduireBrut!(@board,difficulty[1])
    @board.difficulty = level
    @board.freeze
    print "\n Nb cases: ", @board.usedCells.length,"\n Lvl: ", level,"\n"
    return @board
  end

end
