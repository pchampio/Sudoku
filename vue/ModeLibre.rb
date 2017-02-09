require 'gtk3'
require_relative './GridPanel.rb'
require_relative '../class/board_class.rb'

class ModeLibre < Gtk::Window
	def initialize
		super
		signal_connect 'destroy' do 
			Gtk.main_quit
		end

		init_ui
	end

	def init_ui
		set_title "Mode libre"
		set_default_size 300, 300
		set_resizable true

		hbox = Gtk::HBox.new(false, 10)
		vbox = Gtk::VBox.new(false, 15)
		hbox.add(init_grille)
		vbox.add(Gtk::Label.new("Chiffre entree"))
		vbox.add(init_button_chiffre_entree)
		vbox.add init_button_status
		hbox.add(vbox)
		add(hbox)
		show_all
	end

	def init_grille
		#connect la class Generator
		planche_base = "
  		_ _ _   _ _ 4   _ _ _
  		_ _ _   _ _ 3   _ _ 9
  		_ 8 _   _ _ 1   _ _ 2

 		 _ _ 4   _ 6 8   _ _ _
  		7 _ _   _ _ _   8 _ _
  		9 _ _   4 _ _   _ 5 6

 		 _ 3 _   _ 2 _   _ _ _
 		 6 9 _   _ 5 _   _ 2 _
 		 _ _ 7   1 _ _   _ _ _
   		 ".tr("_", "0")
    	board = Board.creer(planche_base.delete("\s|\n")
      		.split("").reverse.map(&:to_i))
		@grille=GridPanel.new(board)
		return @grille
	end

	def init_button_chiffre_entree
		@buttonTable = Gtk::Table.new 3, 3, true
		listButton = creer_list_button_chiffre 
		0.upto(2) do |i|
			0.upto(2) do |j|
				@buttonTable.attach(listButton[j][i], i, i+1, j, j+1, nil, nil, 3, 3)
			end
		end
		return @buttonTable
	end

	def creer_list_button_chiffre
		@listButton = Array.new(3){Array.new(3)}
		inde = 1
		0.upto(2) do |i|
			0.upto(2) do |j|
				@listButton[i][j] = Gtk::Button.new(inde.to_s)
				inde+=1
			end
		end
		return @listButton
	end

	def init_button_status
		listButtonStatus = creer_list_button_status
		@buttonStatusTable = Gtk::Table.new 3, 3, true
		0.upto(2) do |i|
			0.upto(2) do |j|
				@buttonStatusTable.attach listButtonStatus[i][j], j, j+1, i, i+1
			end
		end
		return @buttonStatusTable
	end

	def creer_list_button_status
		@Index1 = ["Pencil","Undo",
					"Valid", "Good",
						"Well", "Bad"]
		@listButtonStatus = Array.new(3) { Array.new(3)  }
		0.upto(2) do |i|
			0.upto(2) do |j|
				if j == 1
					@listButtonStatus[i][j] = Gtk::Label.new("")
				else
					@listButtonStatus[i][j] = Gtk::Button.new(@Index1.pop)
				end
			end
		end
		return @listButtonStatus
	end


end

m = ModeLibre.new()
Gtk.main