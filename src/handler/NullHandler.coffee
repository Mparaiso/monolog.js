AbstractHandler = require('./AbstractHandler')

class NullHandler extends AbstractHandler
	###
		Any record it can handle will be thrown away. This can be used
    	to put on top of an existing stack to override it temporarily.
   	###
	handle:(record)->
		if record.level < @level 
			false 
		else 
			super
			true