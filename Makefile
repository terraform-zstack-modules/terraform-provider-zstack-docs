.PHONY: quality fmt docs hooks

quality:
	./scripts/quality-gate.sh

fmt:
	terraform fmt -recursive examples skills

docs:
	python3 -m mkdocs build --strict

hooks:
	./scripts/install-git-hooks.sh
