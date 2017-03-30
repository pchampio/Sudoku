require 'gtk3'

Dir[File.dirname(__FILE__) + '../class/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }


class InGameMenu < Gtk::Frame

  @@mode_ecriture = :chiffre # 2 possibles (chiffre, candidates)
  @@audo_maj_candidates = false

  def self.mode_ecriture
    return @@mode_ecriture
  end

  def self.audo_maj_candidates
    return @@audo_maj_candidates
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

    audo_maj_candidates_hbox = Gtk::Box.new(:horizontal,5)
    audo_maj_candidates_lab = Gtk::Label.new("Candidates auto-généré")
    audo_maj_candidates_sw = Gtk::Switch.new

    audo_maj_candidates_hbox.add(audo_maj_candidates_lab)
    audo_maj_candidates_hbox.add(audo_maj_candidates_sw)



    audo_maj_candidates_sw.signal_connect('state-set') do
      @@audo_maj_candidates = audo_maj_candidates_sw.active?
      if @@audo_maj_candidates
        @boardComp.showPossibles
      else
        @boardComp.hidePossibles
      end
      audo_maj_candidates_sw.state = @@audo_maj_candidates
    end

    buttonPen = Gtk::RadioButton.new :label => "Stylo"
    buttonPen.signal_connect('clicked'){@@mode_ecriture = :chiffre}

    buttonCrayon = Gtk::RadioButton.new :label => "Crayon"
    buttonCrayon.join_group(buttonPen)
    buttonCrayon.signal_connect('clicked'){@@mode_ecriture = :candidates}

    buttonFullPossibilities = Gtk::Button.new(:label=>"Ajouter tous les candidates !", :use_underline => true)
    buttonFullPossibilities.signal_connect('clicked'){
      @boardComp.showPossibles
    }

    boxTechnic = Gtk::Box.new(:horizontal,2)
    cb = Gtk::ComboBoxText.new
    boxTechnic.add(cb)
    cb.append_text ""
    cb.append_text "Technique de l'aigle"
    cb.append_text "Technique du dauphin"
    cb.append_text "Technique du tigre"
    cb.append_text "Techique de la panthère"
    cb.append_text "Technique du serpent"

    buttTechnic=Gtk::Button.new(:label => "valider",:use_underline => true);
    buttTechnic.signal_connect('clicked'){puts cb.active_text}
    boxTechnic.add(buttTechnic)


    @pan.add(boxTechnic)
    @pan.add(buttonPen)
    @pan.add(buttonCrayon)

    @pan.add(buttonFullPossibilities)
    @pan.add(audo_maj_candidates_hbox)
    self.add(@pan)
  end

end
