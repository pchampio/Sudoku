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

# add shuffle Hash class
class Hash
  def shuffle
    Hash[self.to_a.sample(self.length)]
  end

  def shuffle!
    self.replace(self.shuffle)
  end
end

class Suggest

  attr_reader :board#:nodoc:

  def initialize(board)
    @board = board

    # info
    @text_info = []
    @box_highlight = []
    @number_highlight = []
    @show_popup = []

    create_candidate
  end

  def self.creer(board)
    new(board)
  end
  private_class_method :new


  # initialisation des conteneurs des valeurs possibles
  private def create_candidate

    # les possibles valeurs sur les boxes
    @boxes = {}
    @rows = {}
    @cols = {}

    @possible_in_boxes= {}
    @possible_in_rows= {}
    @possible_in_cols= {}

    @board.each_with_coord do |cell,i,j,box|

      # Met des tableaux dans le hashs
      @boxes[box] = [] if !@boxes.has_key?(box)
      @rows[i] = [] if !@rows.has_key?(i)
      @cols[j] = [] if !@cols.has_key?(j)

      @possible_in_boxes[box] = [] if !@possible_in_boxes.has_key?(box)
      @possible_in_rows[i] = [] if !@possible_in_rows.has_key?(i)
      @possible_in_cols[j] = [] if !@possible_in_cols.has_key?(j)

      possibles = []
      if @board.cellAt(i,j).vide?
        if cell.possibles.empty? or cell.possibles == [0]
          possibles = @board.possibles(cell)
        else
          possibles = cell.possibles - [0]
        end
        (@possible_in_boxes[box] += possibles)
        (@possible_in_rows[i] += possibles)
        (@possible_in_cols[j] += possibles)
      end

      caase = Cell.creer(i, j, box)
      caase.possibles = possibles

      @boxes[box] << caase
      @rows[i] << caase
      @cols[j] << caase
    end
  end

  def aide_text
    @text_info.shift if not @text_info.empty?
  end

  def aide_box
    @box_highlight.shift if not @box_highlight.empty?
  end

  def aide_nombre
    @number_highlight.shift if not @number_highlight.empty?
  end

  def aide_popup
    @show_popup.shift if not @show_popup.empty?
  end

	def hasNextAide
    !@text_info.empty?
	end


  def hiddenSingle_on_container container, cont_possibles
    container.shuffle.each do |cont|

      # Récupération de la Cell qui a une unique possibilité
      uniq_candi = cont_possibles[cont[0]].sort.chunk{ |e| e }.map{ |_a, e| e.first if e.length == 1}.select{|e| e != nil}.first

      # acces au données du hash cont[1] et pas a la clee [0]
      cont[1].shuffle.each do |cell|
        # Si une Cell n'a qu'une possibilité
        # Si le chiffre le moins répéter ne l'est qu'une fois alors c'est la seule possibilité
        if cell.possibles.include?(uniq_candi)

          @text_info << "Etape 1/3\n\nEssayez de remplir la \ngrille avec le \nnombre #{uniq_candi}."
          @number_highlight << nil
          @box_highlight << nil
          @show_popup << nil

          @text_info << "Etape 2/3\n\nDans quelle case du bloc #{cell.box+1} \npouvez-vous mettre le \nnombre #{uniq_candi} ?"
          @number_highlight << uniq_candi
          @box_highlight << cell.box
          @show_popup << nil

          @text_info << "Etape 3/3\n\nDans le bloc #{cell.box+1}, à la ligne #{cell.row+1},\nsur la colonne #{cell.col+1}, il ne peut y\navoir que le nombre #{uniq_candi}."
          @number_highlight << uniq_candi
          @box_highlight << cell.box
          @show_popup << [cell.row, cell.col]

          return true
        end
      end
    end
    return false
  end

  def hiddenSingle
    bool = hiddenSingle_on_container @boxes, @possible_in_boxes
    bool = hiddenSingle_on_container @rows, @possible_in_rows unless bool
    bool = hiddenSingle_on_container @cols, @possible_in_cols unless bool
    @text_info << "Cette technique ne permet \npas actuellement de révéler de \nnouvelle case..." unless bool
  end

  def nakedSingle_on_container container
    container.shuffle.each do |cont|
      # acces au données du hash cont[1] et pas a la clee [0]
      cont[1].shuffle.each do |cell|
        # Si une Cell n'a qu'une possibilité
        # Si le chiffre le moins répéter ne l'est qu'une fois alors c'est la seule possibilité
        if cell.possibles.length == 1

          @text_info << "Etape 1/3\n\nEssayez de remplir la \ngrille avec le nombre #{cell.possibles.first}."
          @number_highlight << nil
          @box_highlight << nil
          @show_popup << nil

          @text_info << "Etape 2/3\n\nDans quelle case du bloc #{cell.box+1} \npouvez-vous mettre le \nnombre #{cell.possibles.first} ?"
          @number_highlight << cell.possibles.first
          @box_highlight << cell.box
          @show_popup << nil

          @text_info << "Etape 3/3\n\nDans le bloc #{cell.box+1}, à la ligne #{cell.row+1},\nsur la colonne #{cell.col+1}, il ne peut y avoir\nque le nombre #{cell.possibles.first}."
          @number_highlight << cell.possibles.first
          @box_highlight << cell.box
          @show_popup << [cell.row, cell.col]

          return true
        end
      end
    end
    return false
  end

  def nakedSingle
    bool = nakedSingle_on_container @boxes
    bool = nakedSingle_on_container @rows unless bool
    bool = nakedSingle_on_container @cols unless bool
    @text_info << "Cette technique ne permet \npas actuellement de révéler de \nnouvelle case..." unless bool
  end

  def jumeauxEtTriples_on_container container, cont_possibles
    container.each do |cont|

      # Récupération de la Cell qui a une unique possibilité
      jumeaux = cont_possibles[cont[0]].sort.chunk{ |e| e }.map{ |_a, e| e.first if e.length >= 2}.select{|e| e != nil}.first

      print jumeaux,"\n"

      cellOfMethod = []
      cont[1].each do |cell|
        if cell.possibles.include? jumeaux
          cellOfMethod << cell
        end
      end
      break if cellOfMethod.length < 2

      boxe = nil
      cellOfMethod.each do |cell|
        cellOfMethod.each do |v|
          if cell.box == v.box
            boxe = cell.box
          end
        end
      end

      cellOfMethod.each do |cell|
        if cell.box != boxe
          cellOfMethod.remove cell
        end
      end

      puts
      print boxe,"\n"

      cellOfMethod.each do |cellofmethod|
        print cellofmethod,"\n"
      end

      @board.each_with_coord do |cell, i, j, box|
        if cell.box != boxe
          if cell.row == cellOfMethod.first.row and cell.possibles.include? jumeaux
            print cell," possible - ", jumeaux,"\n"
          end
        end

      end

      # print triples,"\n"
      # cellOfMethod = []
      # cont[1].each do |cell|
      # if cell.possibles.include? triples
      # if cellOfMethod.empty?
      # cellOfMethod << cell
      # else
      # if cellOfMethod.first.box == cell.box and \
      # (cellOfMethod.first.row == cell.row or cellOfMethod.first.col == cell.col)
      # then
      # cellOfMethod << cell
      # end
      # end
      # end
      # end

      # cellOfMethod.each do |cellofmethod|
      # print cellofmethod,"\n"
      # end


      # return false

    end
    return false
  end

  def JumeauxEtTriples
    bool = jumeauxEtTriples_on_container @rows, @possible_in_rows
    bool = jumeauxEtTriples_on_container @cols, @possible_in_cols unless bool
    @text_info << "Cette technique ne permet \npas actuellement de révéler de \nnouvelle case..." unless bool
  end


end
