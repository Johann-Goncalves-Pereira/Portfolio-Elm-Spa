clean:
	rm -f public/js/index.*
	rm -f public/css/index.*
	rm -f public/index.html
	rm -rf node_modules
	rm -rf elm-stuff
dep:
	yarn install

dev: dep
	yarn run-script build:dev

prod: dep
	yarn run-script build
