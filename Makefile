.DEFAULT_GOAL:=latest-samba

latest-samba:
	dev/latest-published-samba.sh

push-to-dockerhub:
	dev/update-tags-and-push-to-dockerhub.sh

amd64-build:
	dev/amd64/build.sh

amd64-run:
	dev/amd64/run.sh

amd64-test:
	dev/amd64/test.sh

amd64-test-dns:
	dev/amd64/test-dns.sh

amd64-clean:
	dev/amd64/clean.sh

arm64-build:
	dev/arm64/build.sh

arm64-run:
	dev/arm64/run.sh

arm64-test:
	dev/arm64/test.sh

arm64-clean:
	dev/arm64/clean.sh
