default: build
.PHONY: default

menu: ## prints out the menu of command options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(lastword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: menu

build: ## Build the images for the test
	@cd app1 && docker build -t app1:latest .
	@cd app2 && docker build -t app2:latest .
.PHONY: build
