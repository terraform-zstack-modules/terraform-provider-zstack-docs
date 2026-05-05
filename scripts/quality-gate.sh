#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

failures=0

info() {
  printf '[quality] %s\n' "$*"
}

fail() {
  printf '[quality] FAIL: %s\n' "$*" >&2
  failures=$((failures + 1))
}

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    fail "missing required command: $1"
    return 1
  fi
}

info "checking repository layout"
for path in README.md CONTRIBUTING.md LICENSE mkdocs.yml docs examples .githooks .githooks/pre-commit skills/zstack-terraform-usage/SKILL.md; do
  if [ ! -e "$path" ]; then
    fail "missing required path: $path"
  fi
done

if [ ! -x .githooks/pre-commit ]; then
  fail ".githooks/pre-commit must be executable"
fi

require_command rg

info "checking committed sensitive files"
for pattern in 'terraform.tfvars' 'terraform.tfstate' 'terraform.tfstate.*' '*.tfplan' '*.plan' '.env' '.env.*' '*.pem' '*.key' '*.p12' '*.pfx'; do
  if git ls-files -- "$pattern" | grep -q .; then
    fail "sensitive/generated file is tracked: $pattern"
    git ls-files -- "$pattern" >&2
  fi
done

info "checking Terraform formatting"
if require_command terraform; then
  if ! terraform fmt -check -recursive examples skills; then
    fail "terraform fmt check failed"
  fi
fi

info "checking example directory contract"
while IFS= read -r dir; do
  for file in README.md main.tf variables.tf terraform.tfvars.example; do
    if [ ! -f "$dir/$file" ]; then
      fail "$dir is missing $file"
    fi
  done
done < <(find examples/common -mindepth 1 -maxdepth 1 -type d | sort)

info "checking MkDocs nav targets"
if require_command python3; then
  if ! python3 - <<'PY'
import os
import sys

try:
    import yaml
except ImportError:
    print("PyYAML is required for MkDocs nav target checks", file=sys.stderr)
    sys.exit(1)

with open("mkdocs.yml", encoding="utf-8") as fh:
    nav = yaml.safe_load(fh).get("nav", [])

def walk(node):
    if isinstance(node, dict):
        for value in node.values():
            yield from walk(value)
    elif isinstance(node, list):
        for value in node:
            yield from walk(value)
    elif isinstance(node, str):
        yield node

missing = []
for path in walk(nav):
    if "://" in path or path.startswith("#"):
        continue
    if not os.path.exists(os.path.join("docs", path)):
        missing.append(path)

if missing:
    for path in missing:
        print(f"missing MkDocs nav target: docs/{path}", file=sys.stderr)
    sys.exit(1)
PY
  then
    fail "mkdocs nav target check failed"
  fi
fi

info "checking Terraform variable descriptions"
while IFS= read -r missing; do
  fail "$missing"
done < <(
  find examples skills -name '*.tf' -print | sort | while IFS= read -r file; do
    awk '
      /^[[:space:]]*variable[[:space:]]+"[^"]+"[[:space:]]*\{/ {
        in_var = 1
        has_description = 0
        start_line = FNR
      }
      in_var {
        line = $0
        if (line ~ /^[[:space:]]*description[[:space:]]*=/) {
          has_description = 1
        }
        gsub(/"([^"\\]|\\.)*"/, "\"\"", line)
        open_count = gsub(/\{/, "{", line)
        close_count = gsub(/\}/, "}", line)
        depth += open_count - close_count
        if (depth <= 0) {
          if (!has_description) {
            printf "%s:%d: variable block must include description\n", FILENAME, start_line
          }
          in_var = 0
          depth = 0
        }
      }
    ' "$file"
  done
)

info "checking provider version consistency"
if rg -n -P '^\s*source\s*=\s*"(?!ZStack-Robot/zstack")' examples skills --glob '*.tf' >/tmp/zstack-provider-source-mismatch.$$ 2>/dev/null; then
  cat /tmp/zstack-provider-source-mismatch.$$ >&2
  rm -f /tmp/zstack-provider-source-mismatch.$$
  fail "Terraform provider source must remain ZStack-Robot/zstack unless the docs baseline is upgraded"
else
  rm -f /tmp/zstack-provider-source-mismatch.$$
fi

if rg -n -P '^\s*version\s*=\s*"(?!1\.1\.2")' examples skills --glob '*.tf' >/tmp/zstack-provider-version-mismatch.$$ 2>/dev/null; then
  cat /tmp/zstack-provider-version-mismatch.$$ >&2
  rm -f /tmp/zstack-provider-version-mismatch.$$
  fail "Terraform provider version must remain 1.1.2 unless the docs baseline is upgraded"
else
  rm -f /tmp/zstack-provider-version-mismatch.$$
fi

info "checking deprecated provider patterns"
if rg -n 'l3_network_uuids' examples skills --glob '*.tf' >/tmp/zstack-deprecated-patterns.$$ 2>/dev/null; then
  cat /tmp/zstack-deprecated-patterns.$$ >&2
  rm -f /tmp/zstack-deprecated-patterns.$$
  fail "deprecated or discouraged provider pattern found"
else
  rm -f /tmp/zstack-deprecated-patterns.$$
fi

info "checking placeholder hygiene"
if rg -n -P 'zstack_access_key_secret\s*=\s*"((?!replace-me).)+"' examples --glob 'terraform.tfvars.example' >/tmp/zstack-secret-placeholders.$$ 2>/dev/null; then
  cat /tmp/zstack-secret-placeholders.$$ >&2
  rm -f /tmp/zstack-secret-placeholders.$$
  fail "tfvars examples must use placeholder secrets"
else
  rm -f /tmp/zstack-secret-placeholders.$$
fi

info "checking documentation links to root examples"
if rg -n '\]\((\.\./)*examples/common/' docs --glob '*.md' >/tmp/zstack-relative-example-links.$$ 2>/dev/null; then
  cat /tmp/zstack-relative-example-links.$$ >&2
  rm -f /tmp/zstack-relative-example-links.$$
  fail "docs pages must link root examples through GitHub URLs, not MkDocs-relative paths"
else
  rm -f /tmp/zstack-relative-example-links.$$
fi

info "checking GitHub branch links in docs"
if rg -n -P 'github\.com/.*/tree/(?!main/)' docs --glob '*.md' >/tmp/zstack-github-branch-links.$$ 2>/dev/null; then
  cat /tmp/zstack-github-branch-links.$$ >&2
  rm -f /tmp/zstack-github-branch-links.$$
  fail "docs GitHub tree links must target main or use release-time SHA permalinks"
else
  rm -f /tmp/zstack-github-branch-links.$$
fi

if [ "$failures" -ne 0 ]; then
  printf '[quality] completed with %d failure(s)\n' "$failures" >&2
  exit 1
fi

info "all checks passed"
