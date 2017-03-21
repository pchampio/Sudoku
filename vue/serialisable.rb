require 'gtk3'

class Serialisable
	@@backgroundColor
	@@selectColor

	def self.getBackgroundColor()
		return @@backgroundColor
	end

	def self.setBackgroundColor(backgroundColor)
		@@backgroundColor = backgroundColor
	end

	def self.getSelectColor()
		return @@selectColor
	end

	def self.setSelectColor(selectColor)
		@@selectColor = selectColor
	end

	# Serialize une planche.
	# * *Arguments*    :
	#   - +nameFic+  -> le nom du fichier pour la sauvegarde
	def self.serialized(nameFic)
		puts "coucou"
		File.open(nameFic, "w+") do |f|
		YAML.dump(self, f)
		end
	end

	# Serialize une planche.
	# * *Arguments*    :
	#   - +nameFic+  -> le nom du fichier pour la sauvegarde
	# * *Returns*      :
	#   - le fichier chargé et convertit en langage machine
	def self.unserialized(nameFic)
		return YAML.load_file(nameFic)
	end

end