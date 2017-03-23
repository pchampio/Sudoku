require 'gtk3'

class Serialisable

  attr_reader :selectColor, :backgroundColor

	def initialize()
	    @backgroundColor =  @@backgroundColor.to_s
	    @selectColor     =  @@selectColor.to_s
	end

	def self.getBackgroundColor()
		return @@backgroundColor
	end

	def self.setBackgroundColor(backgroundColor)
		@@backgroundColor = backgroundColor
	end

	def self.getSelectColor()
		return @@selectColor
	end;

	def self.setSelectColor(selectColor)
		@@selectColor = selectColor
	end

	# Serialize une planche.
	# * *Arguments*    :
	#   - +nameFic+  -> le nom du fichier pour la sauvegarde
	def self.serialized(nameFic)
    obj = Serialisable.new
		File.open(nameFic, "w+") do |f|
      YAML.dump(obj, f)
		end
	end

	# Serialize une planche.
	# * *Arguments*    :
	#   - +nameFic+  -> le nom du fichier pour la sauvegarde
	# * *Returns*      :
	#   - le fichier chargé et convertit en langage machine
	def self.unserialized(nameFic)
    obj = YAML.load_file(nameFic)
   	self.setBackgroundColor(Gdk::Color.parse(obj.backgroundColor))
    self.setSelectColor(Gdk::Color.parse(obj.selectColor))
	end

end
