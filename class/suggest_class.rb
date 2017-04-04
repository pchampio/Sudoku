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


  def hiddenSingle_on_container container, cont_possibles, from
    container.each_with_index do |cont,index_cont|

      # Récupération de la Cell qui a une unique possiblé
      minRepeated_number = cont_possibles[cont[0]].sort.chunk{ |e| e }.map{ |_a, e| e.first if e.length == 1}.select{|e| e != nil}.first

      # acces au données du hash cont[1] et pas a la clee [0]
      cont[1].each do |cell|
        # Si une Cell n'a qu'une possibilité
        # Si le chiffre le moins répéter ne l'est qu'une fois alors c'est la seule possibilité
        if cell.possibles.include?(minRepeated_number)
          puts from
          puts "Examine the digit #{minRepeated_number}."
          puts "Where in block #{cell.box+1} can you put a #{minRepeated_number}?"
          puts "Only R#{cell.row+1}C#{cell.col+1} can be #{minRepeated_number}."


          puts "board avant"
          print @board
          @board.cellAt(cell.row,cell.col).value= minRepeated_number
          puts "board apres ajout"
          print @board
          @board.cellAt(cell.row,cell.col).value= 0
          puts "nombres de repetition"
          require "pp"
          PP.pp cont_possibles[cont[0]].sort.chunk{ |e| e }.map{ |_a, e| "#{e.length} fois le #{e.first}"}
          puts "Valeurs possible dans la case"
          print cell.possibles
          puts
          puts "\n--------------------"
          puts "--------------------"
          puts


        end
      end
    end
  end

  def hiddenSingle
    hiddenSingle_on_container @boxes, @possible_in_boxes,"boxe"
    hiddenSingle_on_container @rows, @possible_in_rows,"row"
    hiddenSingle_on_container @cols, @possible_in_cols,"col"
  end

  def nakedSingle_on_container container, cont_possibles, from
    container.each_with_index do |cont,index_cont|


      # acces au données du hash cont[1] et pas a la clee [0]
      cont[1].each do |cell|
        # Si une Cell n'a qu'une possibilité
        # Si le chiffre le moins répéter ne l'est qu'une fois alors c'est la seule possibilité
        if cell.possibles.length == 1
          puts from
          puts "Examine the digit #{cell.possibles.first}."
          puts "Where in block #{cell.box+1} can you put a #{cell.possibles.first}?"
          puts "Only R#{cell.row+1}C#{cell.col+1} can be #{cell.possibles.first}."


          puts "board avant"
          print @board
          @board.cellAt(cell.row,cell.col).value= cell.possibles.first
          puts "board apres ajout"
          print @board
          @board.cellAt(cell.row,cell.col).value= 0
          puts "Valeurs possible dans la case"
          print cell.possibles
          puts
          puts "\n--------------------"
          puts "--------------------"
          puts


        end
      end
    end
  end
  def nakedSingle
    nakedSingle_on_container @boxes, @possible_in_boxes,"boxe"
    nakedSingle_on_container @rows, @possible_in_rows,"row"
    nakedSingle_on_container @cols, @possible_in_cols,"col"
  end
  
  def getSamePossibles container, cont_possibles, nb
    @tab=[]
    container.each_with_index do |cont,index|
      cont[1].each do |cell|
        @tab_cell = []
        if (cell.possibles.length == nb)
          @tab_cell<<cell
      for i in range @tab_cell.length
        for j in range @tab_cell.length
          if(i != j && @tab_cell[i].possibles == @tab_cell[j].posibles)
            @tab << @tab_cell[i]
            @tab << @tab_cell[j]          
      @tab_cell
  end
    

  def nakedPair_on_container container, cont_possibles, from
    if (@tab_cell = getSamePossibilities(container, cont_possibles, 2)).length==2
        puts "Examine the cells R#{@tab_cell[0].row+1}C#{@tab_cell[0].col+1} and R#{@tab_cell[1].row+1}C#{@tab_cell[1].col+1}"
        puts "They're the only cells in this #{from} to have those possibilities : #{@tab_cell[0].possibles}"
  end    

end
