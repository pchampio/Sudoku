require 'gtk3'
require_relative '../class/board_class.rb'
require_relative '../class/generator_class.rb'
require_relative './route_arcade_game.rb'

class ArcadeModeChoice < Gtk::Frame
	@difficulty = 0

	def initialize(window)
		super()
		@window=window
		window.set_window_position Gtk::WindowPosition::CENTER
		@event1 = Gtk::Box.new(:vertical,5)
		@event1.set_homogeneous("r")
		label_title = Gtk::Label.new "Jeu Arcade", :use_underline => true
		label_difficulty = Gtk::Label.new "Difficulté :", :use_underline => true

		@event1.add(label_title)

		difficultyBox =Gtk::Box.new(:horizontal,5).add(label_difficulty)
		difficultyBox.set_homogeneous("r")
		box = Gtk::Box.new(:horizontal,2)
		box.set_homogeneous("r")

		begginButton=Gtk::Button.new(:label=>"Commencer")
		begginButton.signal_connect("clicked"){commencerPartie}
		menuButton=Gtk::Button.new(:label=>"Retour")
		menuButton.signal_connect("clicked"){
			@window.remove self
			@window.add @window.event1
		}

		box.add menuButton
		box.add begginButton

		@event1.add(difficultyBox)
		@event1.add box

		self.add @event1

		show_all
	end

	def commencerPartie()

		gameGen = Generator.new
		#@difficulty va être égale à la valeur du score du joueur

		@difficulty=gestion_etoiles()
		puts("\n"+@difficulty+"\n")
		case @difficulty
		when 1
      gameGen.generate(:easy)
		when 2
      gameGen.generate(:medium)
		when 3
      gameGen.generate(:hard)
		when 4
      gameGen.generate(:extreme)
		else
      gameGen.generate(:easy)
		end

		@window.remove self
		game = ArcadeModeGame.new(@window, gameGen.board)
		@window.add(game)
	end

	def gestion_etoiles()
		begin#test si le fichier existe
			f = File.open("./vue/score_saved/saved.txt","r+t")
		rescue#sinon
			puts "Probleme pour trouver le fichier, score =0"
			begin#test si le dossier contenant le fichier existe
				File::new("./vue/score_saved/saved.txt", "w+t")
			rescue#sinon on le fait, puis on fait le fichier
				Dir::mkdir("./vue/score_saved", 0777)
				File::new("./vue/score_saved/saved.txt", "w+t")
			ensure#et on met 0 dedans
			f=File.open("./vue/score_saved/saved.txt","w+t")
			f.print("0")
			end

		end
		f = File.open("./vue/score_saved/saved.txt","rt")
		score=f.read
		return score
	end

end

