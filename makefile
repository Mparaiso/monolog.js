test: build
	@mocha -R spec
build:
	@./node_modules/.bin/coffee -m -b -o lib -c src 
commit:
	@git add .
	@git commit -am"auto-update `date`" | :
.PHONY: commit test 