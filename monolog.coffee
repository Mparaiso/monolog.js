monolog = exports 
_ = require('underscore')

class monolog.Logger 
	@DEBUG=100
	@INFO=200
	@NOTICE=250
	@WARNING=300
	@ERROR=400
	@CRITICAL=500
	@ALERT=550
	@EMERGENCY=600
	@API=1
	@levels=
		100:'DEBUG'
		200:'INFO'
		250:'NOTICE'
		300:'WARNING'
		400:'ERROR'
		500:'CRITICAL'
		550:'ALERT'
		600:'EMERGENCY'
