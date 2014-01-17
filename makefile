test: build
	@mocha -R spec
build:
	@./node_modules/.bin/coffee -m -b -o lib -c src 
commit: build
	@git add .
	@git commit -am"auto-update `date`" | :
push: commit build
	@git push origin --all
.PHONY: commit test push