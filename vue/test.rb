require 'gtk3'

class App < Gtk::Window
	def initialize
		super
		set_title "Bienvenue Sudoku"
		set_default_size 300, 300
		set_resizable true
		set_name 'App'
		signal_connect 'destroy'  do
			Gtk.main_quit
		end
		#override_background_color :normal, Gdk::RGBA.new(0,65532,0)
		#override_color :normal, Gdk::RGBA.new(65532,0,0)
		init_ui
	end

		def init_ui

			vbox = Gtk::Box.new(:vertical, 10)
			#fdia = Gtk::FontChooserDialog.new(:title => "Select font name",:parent=>nil)
			vbox.set_name "VBox"
			vbox.set_halign(:center)
			vbox.set_valign(:center)
			button1 = Gtk::Button.new :label=>"button1"
			#button1.override_background_color :normal, Gdk::RGBA.new(899,0,65535,1)
			#button1.child.override_font(Pango::FontDescription.new(fdia.font_desc))

			#button1.child.override_background_color :normal, Gdk::RGBA.new(65532,1,0)
			#button1.override_background_color :prelight, Gdk::RGBA.new(78,78,65532)
			button1.set_name "GtkButton1"
			button2 = Gtk::Button.new :label=>"button2" 
			#button2.override_color :normal, Gdk::RGBA.new(0,65532,0)
			#button2.override_symbolic_color 'Good job', Gdk::RGBA.new(3000,3000,3000)
			button2.set_name "GtkButton2"
			vbox.add(button1)
			vbox.add(button2)

			add(vbox)

			show_all

			provider=simple_css
			apply_css self, provider
		end

		def apply_css(widget, provider)
			widget.style_context.add_provider provider, GLib::MAXUINT
			if widget.is_a?(Gtk::Container)
				widget.each_all do |child|
					apply_css(child, provider)
				end
			end
		end

		def simple_css()
			css = <<-EOT
					#App{
						background-color: #ffcc33;
					}
					#GtkButton1{
						background: #9933ff;
						border-radius: 15px;
						color: #ff3333;
						padding: 12px 4px;
					}
					#GtkButton2{
						background: green;
						/*color: #33ffcc;*/
						padding: 20px 6px;
					}
					
					#VBox{
						background-color: #ffff00;
						background-size: 20px 20px;
					}
					
			EOT
			css_provider = Gtk::CssProvider.new
			css_provider.load :data=>css
			return css_provider
		end
end

App.new
Gtk.main()
