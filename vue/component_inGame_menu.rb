require 'gtk3'

Dir[File.dirname(__FILE__) + '/../class/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }



class InGameMenu < Gtk::Frame

  @@mode_ecriture = :chiffre # 2 possibles (chiffre, candidates)
  @@mode_maj_ecriture = false
  @@auto_maj_candidates = false

  def self.mode_ecriture
    return @@mode_ecriture
  end

  def self.mode_ecriture=mode
    @@mode_ecriture = mode
  end

  def self.auto_maj_candidates
    return @@auto_maj_candidates
  end

  private_class_method :new
  def self.create(boardComponent)
    new(boardComponent)
  end

  def initialize(boardComponent)
    super()
    @boardComp = boardComponent

    init_ui
    show_all
  end


  def init_ui
    pan=Gtk::Box.new(:vertical,6)

    auto_maj_candidates_hbox = Gtk::Box.new(:horizontal,5)
    auto_maj_candidates_lab = Gtk::Label.new("Candidates auto-généré")
    auto_maj_candidates_lab.margin = 5
    auto_maj_candidates_sw = Gtk::Switch.new

    auto_maj_candidates_hbox.pack_start(auto_maj_candidates_lab , :expand=>true, :fill=>true, :padding=>15)
    auto_maj_candidates_hbox.pack_start(auto_maj_candidates_sw, :expand=>true, :fill=>true, :padding=>15)

    wayWrite_hbox = Gtk::Box.new(:horizontal,5)
    labelPen = Gtk::Label.new("Stylo")
    labelPen.margin = 5
    switchWrite = Gtk::Switch.new
    switchWrite.name = "switchWrite"
    switchWrite.margin = 10

    labelCrayon = Gtk::Label.new("Crayon")

    wayWrite_hbox.pack_start(labelPen , :expand=>true, :fill=>true, :padding=>15)
    wayWrite_hbox.pack_start(switchWrite , :expand=>true, :fill=>true, :padding=>15)
    wayWrite_hbox.pack_start(labelCrayon , :expand=>true, :fill=>true, :padding=>15)

    auto_maj_candidates_sw.signal_connect('state-set') do
      @@auto_maj_candidates = auto_maj_candidates_sw.active?
      if @@auto_maj_candidates
        @boardComp.showPossibles
        @boardComp.board.hasUseSolution
      else
        @boardComp.hidePossibles
      end
      auto_maj_candidates_sw.state = @@auto_maj_candidates
    end

    switchWrite.signal_connect('state-set') do
      @@mode_maj_ecriture = switchWrite.active?
      if !@@mode_maj_ecriture
        @@mode_ecriture = :chiffre
      else
        @@mode_ecriture = :candidates
      end
      switchWrite.state = @@mode_maj_ecriture
    end

    #buttonPen = Gtk::RadioButton.new :label => "Stylo"
    #buttonPen.signal_connect('clicked'){@@mode_ecriture = :chiffre}

    #buttonCrayon = Gtk::RadioButton.new :label => "Crayon"
    #buttonCrayon.join_group(buttonPen)
    #buttonCrayon.signal_connect('clicked'){@@mode_ecriture = :candidates}

    buttonFullPossibilities = Gtk::Button.new(:label=>"Ajouter tous les candidats !", :use_underline => true)
    buttonFullPossibilities.margin = 5
    buttonFullPossibilities.signal_connect('clicked'){
      @boardComp.board.hasUseSolution
      @boardComp.showPossibles
    }

    boxTechnic = Gtk::Box.new(:horizontal,2)
    cb = Gtk::ComboBoxText.new
    cb.append "1", "Chiffre Caché"
    cb.append "2", "Paires isolées"
    #cb.append "3", "Jumeaux et triplés"
    cb.active_id = "1"

    buttTechnic=Gtk::Button.new(:use_underline => true);
    labelTech = Gtk::Label.new "Aide "
    buttTechnic.add(labelTech)

    cb.signal_connect "changed" do
        labelTech.set_markup "Aide "
        @boardComp.updateBoardColor
    end
    @oldActiveText = "t"
    board_old = @boardComp.board.copie
    buttTechnic.signal_connect('clicked'){

      if @suggest and
        @suggest.hasNextAide and
        cb.active_text == @oldActiveText and
        board_old == @boardComp.board
      then

        set_text_view @suggest.aide_text
        @boardComp.highlightNumber @suggest.aide_nombre
        @boardComp.highlightBox @suggest.aide_box
        @boardComp.showPopupAt @suggest.aide_popup
      else
        @suggest = Suggest.creer(@boardComp.board)
        board_old = @boardComp.board.copie
        @boardComp.updateBoardColor

        @suggest.hiddenSingle if cb.active_id.to_i == 1
        @suggest.nakedSingle if cb.active_id.to_i == 2

        @oldActiveText = cb.active_text
        if @suggest.hasNextAide
          labelTech.set_markup "Suite"
          set_text_view @suggest.aide_text
          @boardComp.highlightNumber @suggest.aide_nombre
          @boardComp.highlightBox @suggest.aide_box
          @boardComp.showPopupAt @suggest.aide_popup
          @boardComp.board.hasUseSolution
        end
      end
      unless @suggest.hasNextAide
        labelTech.set_markup "Aide "
      end

    }
    boxTechnic.pack_start(cb , :expand=>true, :fill=>true, :padding=>5)
    boxTechnic.pack_start(buttTechnic , :expand=>true, :fill=>true, :padding=>5)

    textView = Gtk::TextView.new()
    textView.set_wrap_mode(:word_char)
    @text = textView.buffer
    @text.set_text "Bienvenue sur notre aide à la résolution d'un sukodu"
    textView.set_editable false
    textView.cursor_visible = false
    textView.left_margin = 10
    textView.right_margin = 20
    textView.set_size_request(-1, 150)


    pan.add(buttonFullPossibilities)
    pan.add(auto_maj_candidates_hbox)
    pan.add(wayWrite_hbox)
    pan.add(Gtk::Label.new(""))
    pan.add(boxTechnic)
    pan.add(textView)

    # pan.pack_start(textView , :expand=>true, :fill=>true, :padding=>15) # take all available space
    self.add(pan)
  end

  def set_text_view(string)
    @text.set_text string
  end

end
