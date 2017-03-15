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
	def serialized(nameFic)
	# file = File.open(nameFic, "w+")
	# puts("Coucou je serialize")
	# jsonSave = YAML::dump(self)
	# file.write(jsonSave)
	# file.close

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
		# file = File.open(nameFic, "r")
		# jsonSave = file.read
		# data = JSON.parse(json)
		# self = data
		return YAML.load_file(nameFic)
	end
  
end