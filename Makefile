SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

clean:
	rm -fr docs

dep:
	pip install -U pip
	pip install -r requirements.txt

generate: clean
	mkdir -p docs
	cp README.md docs/index.md
	find . -maxdepth 2 -mindepth 2 -type f -name README.md -exec sh -c 'cp $${0} docs/$${0%/README.md}.md' {} \;
	printf "\n## Documentation\n\n" | tee -a docs/index.md
	find . -maxdepth 2 -mindepth 2 -type f -name README.md -print0 | sort -z | xargs -0 -n 1 -r sh -c 'echo \* [$$(echo $${0%/README.md}|cut -c 3-)]\($${0%/README.md}.md\)' | tee -a docs/index.md

build: dep generate
	mkdocs build

.PHONY: build clean dep generate
