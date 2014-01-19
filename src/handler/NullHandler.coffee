AbstractHandler = require('./AbstractHandler')

class NullHandler extends AbstractHandler
	###
		Any record it can handle will be thrown away. This can be used
    	to put on top of an existing stack to override it temporarily.
   		@param  {Object}   record 
   		@param  {Function} cb     
   		@return {Boolean}         
   	###
	handle:(record,cb)->
		if record.level < @level 
			cb(new Error('cant handle record'),undefined,record,this)
			false 
		else 
			super
			true