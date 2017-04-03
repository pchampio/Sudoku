#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: CHAMPION Pierre
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#


# === Gestion de cases dans une planche de Sudoku
# === Variables d'instance
# - +row+   -> (*LECTURE*) Ligne de la case dans la planche<br>
# - +col+   -> (*LECTURE*) Colonne de la case dans la planche<br>
# - +box+   -> (*LECTURE*) Boxe de la case dans la planche<br>
# - +value+ -> (*LECTURE* / *ECRITURE*) Valeur de la case (Sudoku) (0==vide)

class Cell
  attr_accessor :value, :possibles#:nodoc:
  attr_reader :row, :col, :box#:nodoc:

  # Chaque case connait sa propre valeur et sa position dans la planche
  def initialize(row, col, box)
    @row, @col, @box = row, col, box
    @possibles = []
    @value = 0
    @freeze = false
  end
  # Représentation d'une case
  # * *Arguments*    :
  #   - +row+ -> Désignation de la ligne de la case
  #   - +col+ -> Désignation de la colonne de la case
  #   - +box+ -> Désignation de la "box"
  # * *Returns*
  #   - Cell
  def self.creer(row, col, box)
    new(row, col, box)
  end
  private_class_method :new

  include Comparable
  # Méthode de comparaison entre différente instance de Cell
  # * *Arguments*    :
  #   - +other+ -> autre Cell a compare
  # * *Returns*
  #   - true/false
  def <=>(other)
    @value <=> other.value
  end
  # Connaitre si une Cell n'est pas remplie
  # * *Returns*
  #   - true/false
  def vide?
    @value == 0
  end

  # Connaitre si la cell est define lors de la generation
  # * *Returns*
  #   - true/false
  def freeze?
    @freeze
  end

  # Met la case en read only
  def freeze
    instance_eval { undef :value= }
    @freeze = true
  end

  # Pour debugging
  # * Exemple
  #    Value: 2, Row: 0, Col: 0, Box: 0
  #    Value: 4, Row: 0, Col: 1, Box: 0
  #    Value: 6, Row: 0, Col: 2, Box: 0
  #    Value: 1, Row: 0, Col: 3, Box: 1
  #    Value: 3, Row: 0, Col: 4, Box: 1
  #    Value: 5, Row: 0, Col: 5, Box: 1
  #    Value: 8, Row: 0, Col: 6, Box: 2
  #    Value: 7, Row: 0, Col: 7, Box: 2
  def to_s
    return "Value: #{@value}, Row: #{@row}, Col: #{@col}, Box: #{@box}"
  end
end
