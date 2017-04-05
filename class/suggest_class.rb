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
    @board = board
    create_candidate
  end

  def self.creer(board)
    new(board)
  end
  private_class_method :new


  # initialisation des conteneurs des valeurs possibles
  private def create_candidate

    # info
    @text_info = []
    @box_highlight = []
    @number_highlight = []
    @show_popup = []

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
        possibles = @board.possibles(cell)
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
    container.each do |cont|

      # Récupération de la Cell qui a une unique possiblé
      minRepeated_number = cont_possibles[cont[0]].sort.chunk{ |e| e }.map{ |_a, e| e.first if e.length == 1}.select{|e| e != nil}.first

      # acces au données du hash cont[1] et pas a la clee [0]
      cont[1].each do |cell|
        # Si une Cell n'a qu'une possibilité
        # Si le chiffre le moins répéter ne l'est qu'une fois alors c'est la seule possibilité
        if cell.possibles.include?(minRepeated_number)

          @text_info << "Examine the digit #{minRepeated_number}."
          @number_highlight << nil
          @box_highlight << nil
          @show_popup << nil

          @text_info << "Where in block #{cell.box+1} can you put a #{minRepeated_number}?"
          @number_highlight << minRepeated_number
          @box_highlight << cell.box
          @show_popup << nil

          @text_info << "Only R#{cell.row+1}C#{cell.col+1} can be #{minRepeated_number}."
          @number_highlight << minRepeated_number
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
    hiddenSingle_on_container @cols, @possible_in_cols unless bool
  end

  def nakedSingle_on_container container
    container.each do |cont|
      # acces au données du hash cont[1] et pas a la clee [0]
      cont[1].each do |cell|
        # Si une Cell n'a qu'une possibilité
        # Si le chiffre le moins répéter ne l'est qu'une fois alors c'est la seule possibilité
        if cell.possibles.length == 1

          @text_info << "Examine the digit #{cell.possibles.first}."
          @number_highlight << nil
          @box_highlight << nil
          @show_popup << nil

          @text_info << "Where in block #{cell.box+1} can you put a #{cell.possibles.first}?"
          @number_highlight << cell.possibles.first
          @box_highlight << cell.box
          @show_popup << nil

          @text_info << "Only R#{cell.row+1}C#{cell.col+1} can be #{cell.possibles.first}."
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
    nakedSingle_on_container @cols unless bool
  end

end
