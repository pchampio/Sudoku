#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: CHAMPION Pierre
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

#:nodoc:
require_relative './board.class.rb'


# === Solver d'une planche de Sudoku
# === Variables d'instance
# - +board+	  -> (*LECTURE*) La planche a résoudre (copie)<br>

class Solver

  def initialize(board)#:nodoc:
    @board = board.copie
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

  # Complète les trous vide dans une planche
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

      # Debug
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
end
