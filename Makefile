lint::
	docker run --rm -i ghcr.io/hadolint/hadolint < Dockerfile

build-dev::
	docker buildx build . --tag iudanet/mkdocs:dev
