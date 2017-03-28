require 'gtk3'

Dir[File.dirname(__FILE__) + '../class/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '*.rb'].each {|file| require file }


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
  def self.create(root_vue, boardComponent)
    new(root_vue, boardComponent)
  end

  def initialize(root_vue, boardComponent)
    super()
    @root_vue=root_vue
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
        @boardComp.affichePossiblite
      else
        @boardComp.deletePossibilite
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
      @boardComp.affichePossiblite()
    }

    # buttonPause = Gtk::Button.new(:label=>"Pause", :use_underline => true)
    # buttonPause.signal_connect('clicked'){
    # @root_vue.pause
    # }

    boxTechnic = Gtk::Box.new(:horizontal,2)
    cb = Gtk::ComboBoxText.new
    boxTechnic.add(cb)
    cb.signal_connect "changed" do |event, label|
      puts event.active_text
    end
    cb.append_text ""
    cb.append_text "Technique de l'aigle"
    cb.append_text "Technique du dauphin"
    cb.append_text "Technique du tigre"
    cb.append_text "Techique de la panthère"
    cb.append_text "Technique du serpent"

    buttTechnic=Gtk::Button.new(:label => "valider",:use_underline => true);
    boxTechnic.add(buttTechnic)


    @pan.add(boxTechnic)
    @pan.add(buttonPen)
    @pan.add(buttonCrayon)

    # @pan.add(buttonPause)

    @pan.add(buttonFullPossibilities)
    @pan.add(audo_maj_candidates_hbox)
    self.add(@pan)
  end

end
