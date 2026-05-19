.PHONY: quality fmt docs hooks ai-site-files

quality:
	./scripts/quality-gate.sh

fmt:
	terraform fmt -recursive examples skills

ai-site-files:
	python3 scripts/generate-ai-site-files.py

docs:
	python3 -m mkdocs build --strict

hooks:
	./scripts/install-git-hooks.sh
