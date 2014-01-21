test: build
	@./node_modules/.bin/mocha -R spec --recursive
cover: build
	@./node_modules/.bin/istanbul cover node_modules/mocha/bin/_mocha -- --recursive -R list
#@cat ./coverage/lcov.info | ./node_modules/coveralls/bin/coveralls.js
build:
	@./node_modules/.bin/coffee -m -b -o lib -c src 
publish: test
	@npm publish
#generate documentation
doc: build
	@./node_modules/.bin/codo -o doc src
commit: build
	@git add .
	@git commit -am"auto-update `date`" | :
push: test doc commit 
	@git push origin master
.PHONY: commit test push doc publish