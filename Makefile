.DEFAULT_GOAL:=latest-samba

.PHONY: latest-samba
latest-samba:
	./dev/latest-published-samba.sh

.PHONY: push-to-dockerhub
push-to-dockerhub:
	./dev/update-tags-and-push-to-dockerhub.sh

.PHONY: amd64-build
amd64-build:
	./dev/amd64/build.sh

.PHONY: amd64-run
amd64-run:
	./dev/amd64/run.sh

.PHONY: amd64-test
amd64-test:
	./dev/amd64/test.sh

.PHONY: amd64-test-dns
amd64-test-dns:
	./dev/amd64/test-dns.sh

.PHONY: amd64-clean
amd64-clean:
	./dev/amd64/clean.sh

.PHONY: arm64-build
arm64-build:
	./dev/arm64/build.sh

.PHONY: arm64-run
arm64-run:
	./dev/arm64/run.sh

.PHONY: arm64-test
arm64-test:
	./dev/arm64/test.sh

.PHONY: arm64-clean
arm64-clean:
	./dev/arm64/clean.sh
