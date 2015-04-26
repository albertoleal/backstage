define HG_ERROR
FATAL: You need Mercurial (hg) to download backstage dependencies.
endef

define GIT_ERROR
FATAL: You need Git to download backstage dependencies.
endef

help:
	@echo '    doc ...................... generates a new doc version'
	@echo '    race ..................... runs race condition tests'
	@echo '    run-api-sample ........... runs api sample server'
	@echo '    run ...................... runs project'
	@echo '    save-deps ................ generates the Godeps folder'
	@echo '    setup .................... sets up the environment'
	@echo '    test ..................... runs tests'

doc:
	@cd docs && make clean && make html SPHINXOPTS="-W"

race:
	go test $(GO_EXTRAFLAGS) -race -i ./...
	go test $(GO_EXTRAFLAGS) -race ./...

run-api-sample:
	go run ./examples/*.go

run:
	foreman start -f Procfile.local

save-deps:
	$(GOPATH)/bin/godep save ./...

setup:
	$(if $(shell hg), , $(error $(HG_ERROR)))
	$(if $(shell git), , $(error $(GIT_ERROR)))
	go get $(GO_EXTRAFLAGS) -u -d -t -v -f ./...
	go get $(GO_EXTRAFLAGS) github.com/tools/godep
	$(GOPATH)/bin/godep restore ./...

test:
	go test ./...
