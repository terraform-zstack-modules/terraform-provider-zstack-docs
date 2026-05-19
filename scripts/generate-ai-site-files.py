#!/usr/bin/env python3
"""Generate site-published AI discovery files from MkDocs navigation."""

from __future__ import annotations

import json
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"
MKDOCS = ROOT / "mkdocs.yml"

PROVIDER = {
    "source": "ZStack-Robot/zstack",
    "version": "1.1.3",
    "terraform_required_version": ">= 1.5",
    "registry_url": "https://registry.terraform.io/providers/ZStack-Robot/zstack/1.1.3",
    "repository_url": "https://github.com/ZStack-Robot/terraform-provider-zstack",
}


def load_config() -> dict:
    with MKDOCS.open(encoding="utf-8") as fh:
        return yaml.load(fh, Loader=yaml.BaseLoader)


def page_url(path: str) -> str:
    if path == "index.md":
        return "/"
    if path.endswith("/index.md"):
        return "/" + path[: -len("index.md")]
    if path.endswith(".md"):
        return "/" + path[:-3] + "/"
    return "/" + path


def page_language(path: str) -> str:
    if path.startswith("zh/"):
        return "zh"
    if path.startswith("en/"):
        return "en"
    return "neutral"


def walk_nav(items, trail=None):
    trail = trail or []
    if isinstance(items, list):
        for item in items:
            yield from walk_nav(item, trail)
    elif isinstance(items, dict):
        for title, value in items.items():
            if isinstance(value, str):
                yield {
                    "title": title,
                    "path": value,
                    "url": page_url(value),
                    "language": page_language(value),
                    "section": " / ".join(trail),
                }
            else:
                yield from walk_nav(value, trail + [title])


def read_page(path: str) -> str:
    full_path = DOCS / path
    if not full_path.exists() or full_path.suffix != ".md":
        return ""
    return full_path.read_text(encoding="utf-8").strip()


def write_catalog(config: dict, pages: list[dict]) -> None:
    api_dir = DOCS / "api"
    api_dir.mkdir(exist_ok=True)
    catalog = {
        "schema_version": "1.0",
        "site": {
            "name": config.get("site_name"),
            "description": config.get("site_description"),
            "type": "static_mkdocs_documentation",
        },
        "provider_baseline": PROVIDER,
        "machine_readable_endpoints": {
            "llms": "/llms.txt",
            "llms_full": "/llms-full.txt",
            "robots": "/robots.txt",
            "mcp_manifest": "/.well-known/mcp.json",
            "openapi": "/openapi.json",
            "catalog": "/api/catalog.json",
        },
        "pages": pages,
    }
    (api_dir / "catalog.json").write_text(
        json.dumps(catalog, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def write_llms_full(config: dict, pages: list[dict]) -> None:
    chunks = [
        f"# {config.get('site_name')} - Full LLM Context",
        "",
        "This file aggregates the Markdown pages published by the documentation site navigation.",
        "Use `/llms.txt` for the concise index and `/api/catalog.json` for structured page metadata.",
        "",
        "## Provider Baseline",
        "",
    ]
    for key, value in PROVIDER.items():
        chunks.append(f"- {key}: {value}")
    chunks.extend(["", "## Pages", ""])

    for page in pages:
        content = read_page(page["path"])
        if not content:
            continue
        chunks.extend(
            [
                f"---",
                f"title: {page['title']}",
                f"url: {page['url']}",
                f"path: docs/{page['path']}",
                f"language: {page['language']}",
                f"section: {page['section']}",
                f"---",
                "",
                content,
                "",
            ]
        )

    (DOCS / "llms-full.txt").write_text("\n".join(chunks).rstrip() + "\n", encoding="utf-8")


def main() -> None:
    config = load_config()
    pages = [p for p in walk_nav(config.get("nav", [])) if p["path"].endswith(".md")]
    write_catalog(config, pages)
    write_llms_full(config, pages)


if __name__ == "__main__":
    main()
