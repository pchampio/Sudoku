require 'gtk2'

class CellView < Gtk::Button
	@hints
	@value

	def Initialize(value)
		super(value)
	end
end
