.DEFAULT_GOAL := help
.PHONY: help setup

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: ## Sets up dependencies
	npm install -g uglify-js uglifycss

minify: ## Creates minified version of Javascript and CSS files
	find . -type f -not -path "./.undodir/*" -path "./src/*" -name "*.js" ! -name "*.min.*" -exec echo {} \; -exec uglifyjs -c -m -o {}.min.js {} \;
	find . -type f -not -path "./.undodir/*" -path "./src/*" -name "*.css" ! -name "*.min.*" -exec echo {} \; -exec uglifycss --output {}.min.css {} \;

	mv ./src/babycalendar.js.min.js ./dist/babycalendar.min.js
	mv ./src/babycalendar.css.min.css ./dist/babycalendar.min.css
