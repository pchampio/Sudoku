require 'gtk3'

Dir[File.dirname(__FILE__) + '../class/*.rb'].each {|file| require file }
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
    @pan=Gtk::Box.new(:vertical,6)

    auto_maj_candidates_hbox = Gtk::Box.new(:horizontal,5)
    auto_maj_candidates_lab = Gtk::Label.new("Candidates auto-généré")
    auto_maj_candidates_lab.margin = 5
    auto_maj_candidates_sw = Gtk::Switch.new

    auto_maj_candidates_hbox.add(auto_maj_candidates_lab)
    auto_maj_candidates_hbox.add(auto_maj_candidates_sw)

    wayWrite_hbox = Gtk::Box.new(:horizontal,5)
    labelPen = Gtk::Label.new("Stylo       ")
    labelPen.margin = 5
    switchWrite = Gtk::Switch.new
    switchWrite.name = "switchWrite"
    switchWrite.margin = 10

    labelCrayon = Gtk::Label.new("       Crayon")

    wayWrite_hbox.add(labelPen)
    wayWrite_hbox.add(switchWrite)
    wayWrite_hbox.add(labelCrayon)

    auto_maj_candidates_sw.signal_connect('state-set') do
      @@auto_maj_candidates = auto_maj_candidates_sw.active?
      if @@auto_maj_candidates
        @boardComp.showPossibles
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
    cb.margin = 5
    boxTechnic.add(cb)
    cb.append_text ""
    cb.append_text "Technique de l'aigle"
    cb.append_text "Technique du dauphin"
    cb.append_text "Technique du tigre"
    cb.append_text "Techique de la panthère"
    cb.append_text "Technique du serpent"

    buttTechnic=Gtk::Button.new(:label => "valider",:use_underline => true);
    buttTechnic.margin = 5
    buttTechnic.signal_connect('clicked'){
      set_text_view cb.active_text
      @boardComp.board.hasUseSolution
    }
    boxTechnic.add(buttTechnic)


    @text = Gtk::TextBuffer.new
    @text.create_tag("warning", "underline" => Pango::UNDERLINE_SINGLE)
    @text.create_tag("error", "underline" => Pango::UNDERLINE_ERROR)

    @text.set_text "Bienvenue sur notre aide à la\n résolution d'un sukodu.\nPour toute réclamation,\nveuillez vous plaindre auprès \nd'Ewen.Merci de votre achat."
    textView = Gtk::TextView.new(@text)
    textView.set_editable false
    textView.cursor_visible = false
    textView.left_margin = 10
    textView.right_margin = 10

    @pan.add(boxTechnic)
   # @pan.add(buttonPen)
   # @pan.add(buttonCrayon)

    @pan.add(buttonFullPossibilities)
    @pan.add(auto_maj_candidates_hbox)
    @pan.add(wayWrite_hbox)
    @pan.add(textView)
    self.add(@pan)
  end

  def set_text_view(string)
    @text.set_text string
  end

end
