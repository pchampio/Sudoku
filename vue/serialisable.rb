require 'gtk3'

class Serialisable
	attr_accessor :backgroundColor, :selectColor
	@@backgroundColor
	@@selectColor

	def getBackgroundColor()
		return @@backgroundColor
	end

	def setBackgroundColor(backgroundColor)
		@@backgroundColor = backgroundColor
	end

	def getSelectColor()
		return @@selectColor
	end

	def setSelectColor(selectColor)
		@@selectColor = selectColor
	end
end