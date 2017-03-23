require 'gtk3'

Dir[File.dirname(__FILE__) + '../class/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '*.rb'].each {|file| require file }


class NumpadComponent < Gtk::Frame
  #variables
  attr_accessor :value #valeur retourner
  attr_reader :statut #gère l'édition des cases : indice ou valeur

  private_class_method :new

  #méthode d'instance
  def NumpadComponent.create panel
    new(panel)
  end

  def initialize panel
    super()
    @panel=panel
    @value=0
    @statut=true
    table = Gtk::Table.new(9,6,true)

    numButtons=Array.new(3){Array.new(3)}

    0.upto(2){|y|
      0.upto(2){|x|
        val=x+y*3+1
        numButtons[x][y]=Gtk::Button.new
        label = Gtk::Label.new

        label.set_markup("<span font='18' ><b>#{val.to_s}</b></span>")
        numButtons[x][y].add(label)

        numButtons[x][y].signal_connect("clicked"){
        	@value=val
        	@panel.recupereNumber(@value)
####################################################################################################################
############################"" Prière de ne pas toucher à ce que je viens de modifier ici bas ######################
####################################################################################################################
        	if (@panel.grid.board.complete?)
	          	@window.remove self
				victoire = FreeModeWin.new(@window)
				@window.add(victoire)
			end
####################################################################################################################
############################ Jusqu'ici quoi ###############################################################
####################################################################################################################

        }
        table.attach(numButtons[x][y],2*x,2*(x+1),2*y,2*(y+1))
      }
    }

    buttonPen = Gtk::RadioButton.new :label => "Stylo"
    buttonPen.signal_connect('clicked'){@statut=true}


    buttonFullPossibilities = Gtk::Button.new(:label=>"Ajouter tous les indices !", :use_underline => true)
    buttonFullPossibilities.signal_connect('clicked'){
      cells = @panel.grid.board.unusedCells
      cells.each do |cell|
        possibles = @panel.grid.board.possibles(cell)
        @panel.grid.cellsView[cell.row][cell.col].set_hints(possibles)
      end
    }

    #--------------------------CHANGER L'ETAT D'UN BOUTON----------------------------
    #
    #
    #___________________buttonFullPossibilities.set_sensitive(false)
    #
    #
    #--------------------------------------------------------------------------------

    buttonCrayon = Gtk::RadioButton.new :label => "Crayon"
    buttonCrayon.join_group(buttonPen)
    buttonCrayon.signal_connect('clicked'){@statut=false}

    buttonGomme = Gtk::Button.new(:label=>"gomme", :use_underline => true)
    buttonGomme.signal_connect('clicked'){
        @panel.recupereNumber(0)
    }

    table.attach(buttonPen,0,2,7,8)
    table.attach(buttonCrayon,2,4,7,8)
    table.attach(buttonGomme,0,6,6,7)
    table.attach(buttonFullPossibilities,0,6,8,9)
    self.add(table)

    show_all()
  end

end
