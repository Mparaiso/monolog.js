commit:
	@git add .
	@git commit -am"auto-update `date`" | :
.PHONY: commit