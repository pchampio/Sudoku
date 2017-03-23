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
    @pan=Gtk::Box.new(:vertical,6)
    @table = Gtk::Table.new(3,3,true)
    @pan.add(@table)

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
	          	@panel.victoire
			end
####################################################################################################################
############################ Jusqu'ici quoi ###############################################################
####################################################################################################################

        }
        @table.attach(numButtons[x][y],2*x,2*(x+1),y,(y+1))
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
    boxTechnic = Gtk::Box.new(:horizontal,2)
    cb = Gtk::ComboBoxText.new
    boxTechnic.add(cb)
    @techniqueValue=""
        cb.signal_connect "changed" do |event, label|
            @technicValue=event.active_text
            puts @technicValue
        end
        cb.append_text ""
        cb.append_text "Technique de l'aigle"
        cb.append_text "Technique du dauphin"
        cb.append_text "Technique du tigre"
        cb.append_text "Techique de la panthère"
        cb.append_text "Technique du serpent"
      buttTechnic=Gtk::Button.new(:label => "valider",:use_underline => true);
      boxTechnic.add(buttTechnic)
      

    imgGomme = Gtk::Image.new :file => "./ressources/gomme.png"
    boxGomme = Gtk::Box.new(:horizontal,1)
    buttonGomme = Gtk::Button.new(:label=>nil, :use_underline => true)
    boxGomme.add(imgGomme)
    buttonGomme.add(boxGomme)
    @pan.add(buttonGomme)

    buttonGomme = Gtk::Button.new(:label=>"gomme", :use_underline => true)

    buttonGomme.signal_connect('clicked'){
        @panel.recupereNumber(0)
    }
    @pan.add(buttonGomme)
    @pan.add(boxTechnic)
    @pan.add(buttonPen)
    @pan.add(buttonCrayon)

    @pan.add(buttonFullPossibilities)
    self.add(@pan)


    show_all()
  end

end
