require 'gtk3'

class OptionMode < Gtk::Frame

	def initialize(window)
		super()
		@window=window
		#set_title "Options"
		#set_default_size 300, 300
		#set_resizable true

		#signal_connect 'destroy'  do
		#	Gtk.main_quit			
		#end
		init_ui
	end

	def init_ui
		
		event1 = Gtk::VBox.new(true,5)
		label_title = Gtk::Label.new "Options", :use_underline => true
		event1.add(label_title)

		self.add event1

		show_all
	end

end

#Gtk.init
##option=OptionMode.new()
##Gtk.main
