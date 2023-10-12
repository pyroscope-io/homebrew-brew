.PHONY: generate-formulas
generate-formulas:
	@echo make sure to set PYROSCOPE_TAG environment variable, e.g PYROSCOPE_TAG=v1.0.0
	rm ../go.work
	rm ../go.mod
	cd scripts/generate-formulas && go mod download && go run ./ ${PYROSCOPE_TAG}
