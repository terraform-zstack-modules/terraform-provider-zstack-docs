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

RULES_BASELINE = {
    "docs_ai_schema_version": "1.1",
    "rules_effective_date": "2026-05-19",
    "applies_to_provider_version": PROVIDER["version"],
    "re_evaluate_when": [
        "provider version changes",
        "Terraform resource or data source schemas change",
        "examples are regenerated from a different provider build",
        "ZStack product API behavior changes",
    ],
}

CORE_RULES = [
    "Do not invent ZStack resource names, data source names, attributes, metric names, scheduler job types, route targets, endpoint formats, or cryptographic settings.",
    "Prefer AccessKey authentication for automation.",
    "Prefer UUID lookup when UUIDs are known.",
    "Use exact names only when the target environment guarantees uniqueness.",
    "Use `name_pattern` only for discovery and output matched candidates for review.",
    "Use `network_interfaces` for new VM examples. Do not recommend `l3_network_uuids` for new configurations.",
    "Prefer `for_each` with stable keys for batch resources.",
    "Keep credentials, AccessKey secrets, license text, webhook tokens, private keys, and passwords out of committed files and normal outputs.",
    "Do not claim an example is production-ready unless remote backend, state access control, variables, permissions, naming, tagging, and approval workflow are addressed.",
]

CONTEXT_FILES = [
    {
        "path": "/llms.txt",
        "scope": "concise_index",
        "language": "neutral",
        "description": "Concise LLM-oriented site index and core rules.",
        "recommended_when": "Always read first.",
    },
    {
        "path": "/llms-medium.txt",
        "scope": "curated_context",
        "language": "multi",
        "description": "Curated high-signal context for agents with limited context windows.",
        "recommended_when": "Read after llms.txt when full-site context is too large.",
    },
    {
        "path": "/llms-manual.txt",
        "scope": "manual_pages",
        "language": "multi",
        "description": "All manual pages from the MkDocs navigation.",
        "recommended_when": "Use for provider configuration, resource usage, and operational guidance.",
    },
    {
        "path": "/llms-scenarios.txt",
        "scope": "scenario_and_example_pages",
        "language": "multi",
        "description": "Scenario pages and example catalog context.",
        "recommended_when": "Use before generating runnable Terraform examples.",
    },
    {
        "path": "/llms-en.txt",
        "scope": "english_pages",
        "language": "en",
        "description": "English documentation pages from the MkDocs navigation.",
        "recommended_when": "Use for English-only retrieval or answer generation.",
    },
    {
        "path": "/llms-zh.txt",
        "scope": "chinese_pages",
        "language": "zh",
        "description": "Chinese documentation pages from the MkDocs navigation.",
        "recommended_when": "Use for Chinese-only retrieval or answer generation.",
    },
    {
        "path": "/llms-full.txt",
        "scope": "full_navigation_context",
        "language": "multi",
        "description": "Full Markdown aggregation from the MkDocs navigation.",
        "recommended_when": "Use only when full context is required.",
    },
]

MACHINE_READABLE_ENDPOINTS = {
    "llms": "/llms.txt",
    "llms_medium": "/llms-medium.txt",
    "llms_manual": "/llms-manual.txt",
    "llms_scenarios": "/llms-scenarios.txt",
    "llms_english": "/llms-en.txt",
    "llms_chinese": "/llms-zh.txt",
    "llms_full": "/llms-full.txt",
    "robots": "/robots.txt",
    "mcp_manifest": "/.well-known/mcp.json",
    "openapi": "/openapi.json",
    "catalog": "/api/catalog.json",
}

MEDIUM_PATHS = {
    "index.md",
    "api/index.md",
    "zh/index.md",
    "zh/ai-native-site.md",
    "zh/manual/index.md",
    "zh/manual/install-environment.md",
    "zh/manual/provider-init-mirror.md",
    "zh/manual/authentication.md",
    "zh/manual/query-existing-resources.md",
    "zh/manual/create-vm.md",
    "zh/manual/networking.md",
    "zh/manual/production-guide.md",
    "zh/scenarios/index.md",
    "zh/scenarios/practice-tutorials.md",
    "zh/troubleshooting/index.md",
    "zh/faq/index.md",
    "en/index.md",
    "en/ai-native-site.md",
    "en/manual/index.md",
    "en/manual/install-environment.md",
    "en/manual/provider-init-mirror.md",
    "en/manual/authentication.md",
    "en/manual/query-existing-resources.md",
    "en/manual/create-vm.md",
    "en/manual/networking.md",
    "en/manual/production-guide.md",
    "en/scenarios/index.md",
    "en/scenarios/practice-tutorials.md",
    "en/troubleshooting/index.md",
    "en/faq/index.md",
    "examples/index.md",
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


def llms_header(config: dict, title: str, description: str) -> list[str]:
    chunks = [
        f"# {config.get('site_name')} - {title}",
        "",
        description,
        "",
        "## Provider Baseline",
        "",
    ]
    for key, value in PROVIDER.items():
        chunks.append(f"- {key}: {value}")
    chunks.extend(
        [
            "",
            "## Rules Baseline",
            "",
            f"- docs_ai_schema_version: {RULES_BASELINE['docs_ai_schema_version']}",
            f"- rules_effective_date: {RULES_BASELINE['rules_effective_date']}",
            f"- applies_to_provider_version: {RULES_BASELINE['applies_to_provider_version']}",
            "- re_evaluate_when:",
        ]
    )
    for reason in RULES_BASELINE["re_evaluate_when"]:
        chunks.append(f"  - {reason}")
    chunks.extend(["", "## Core Rules", ""])
    chunks.extend(f"- {rule}" for rule in CORE_RULES)
    chunks.extend([""])
    return chunks


def page_chunks(pages: list[dict]) -> list[str]:
    chunks = ["## Pages", ""]
    for page in pages:
        content = read_page(page["path"])
        if not content:
            continue
        chunks.extend(
            [
                "---",
                f"title: {page['title']}",
                f"url: {page['url']}",
                f"path: docs/{page['path']}",
                f"language: {page['language']}",
                f"section: {page['section']}",
                "---",
                "",
                content,
                "",
            ]
        )
    return chunks


def write_text_file(path: str, chunks: list[str]) -> None:
    (DOCS / path).write_text("\n".join(chunks).rstrip() + "\n", encoding="utf-8")


def write_llms_index(config: dict) -> None:
    chunks = [
        f"# {config.get('site_name')}",
        "",
        "This is the LLM entrypoint for the ZStack Terraform provider documentation site.",
        "It provides a concise index for AI agents and retrieval systems.",
        "",
        "## Machine-Readable Endpoints",
        "",
    ]
    endpoint_labels = {
        "llms_full": "Full Markdown aggregation",
        "llms_medium": "Curated medium-size context",
        "llms_manual": "Manual-only context",
        "llms_scenarios": "Scenario and example context",
        "llms_english": "English-only context",
        "llms_chinese": "Chinese-only context",
        "catalog": "Structured page catalog",
        "openapi": "OpenAPI description for documentation discovery",
        "mcp_manifest": "MCP manifest",
        "robots": "Robots policy",
    }
    for key, label in endpoint_labels.items():
        chunks.append(f"- {label}: `{MACHINE_READABLE_ENDPOINTS[key]}`")
    chunks.append("- Human site map: `/sitemap.xml`")
    chunks.extend(["", "## Provider Baseline", ""])
    for key, value in PROVIDER.items():
        chunks.append(f"- {key}: {value}")
    chunks.extend(
        [
            "",
            "## Rules Baseline",
            "",
            f"- docs_ai_schema_version: `{RULES_BASELINE['docs_ai_schema_version']}`",
            f"- rules_effective_date: `{RULES_BASELINE['rules_effective_date']}`",
            f"- applies_to_provider_version: `{RULES_BASELINE['applies_to_provider_version']}`",
            "- Re-evaluate these rules when the provider version, Terraform schemas, generated examples, or ZStack product API behavior changes.",
            "",
            "## Recommended Agent Read Order",
            "",
            "1. `/llms.txt`",
            "2. `/api/catalog.json`",
            "3. `/llms-medium.txt` when context is limited",
            "4. `/llms-manual.txt` or `/llms-scenarios.txt` for focused retrieval",
            "5. `/en/manual/index/` or `/zh/manual/index/`",
            "6. `/en/manual/query-existing-resources/` or `/zh/manual/query-existing-resources/`",
            "7. `/en/scenarios/index/` or `/zh/scenarios/index/`",
            "8. `/en/troubleshooting/` or `/zh/troubleshooting/`",
            "9. `/llms-full.txt` only when full context is required",
            "",
            "## Core Rules",
            "",
        ]
    )
    chunks.extend(f"- {rule}" for rule in CORE_RULES)
    chunks.extend(
        [
            "",
            "## Key Human Documentation Paths",
            "",
            "- English overview: `/en/`",
            "- Chinese overview: `/zh/`",
            "- English manual: `/en/manual/`",
            "- Chinese manual: `/zh/manual/`",
            "- Example catalog: `/examples/`",
            "- English troubleshooting: `/en/troubleshooting/`",
            "- Chinese troubleshooting: `/zh/troubleshooting/`",
            "- English FAQ: `/en/faq/`",
            "- Chinese FAQ: `/zh/faq/`",
            "",
            "## Runnable Example Families",
            "",
            "- Provider and discovery: `examples/common/01-provider`, `examples/common/02-query-existing-resources`",
            "- VM lifecycle: `examples/common/03-create-vm`, `examples/common/04-create-10-vms`, `examples/common/13-vm-init-scripts`",
            "- Networking: `examples/common/05-eip`, `examples/common/06-security-group`, `examples/common/07-vpc`, `examples/common/11-load-balancer-web`, `examples/common/12-vpc-routing`",
            "- Storage and image: `examples/common/08-volume`, `examples/common/09-image-query-management`",
            "- Import and metadata: `examples/common/10-import-existing-vm`, `examples/common/14-tags`",
            "- Admin and platform: `examples/common/15-iam-access-key`, `examples/common/16-monitoring-notification`, `examples/common/17-scheduler`, `examples/common/18-global-config`, `examples/common/19-license`",
            "- Backup and advanced networking: `examples/common/20-backup-cdp`, `examples/common/21-network-observability`, `examples/common/22-advanced-network`",
            "- Production references: `examples/production/three-tier-web`, `examples/production/k8s-reference`, `examples/production/import-vm-fleet`, `examples/production/automation-iam`",
        ]
    )
    write_text_file("llms.txt", chunks)


def write_catalog(config: dict, pages: list[dict]) -> None:
    api_dir = DOCS / "api"
    api_dir.mkdir(exist_ok=True)
    catalog = {
        "schema_version": "1.1",
        "site": {
            "name": config.get("site_name"),
            "description": config.get("site_description"),
            "type": "static_mkdocs_documentation",
        },
        "provider_baseline": PROVIDER,
        "rules_baseline": RULES_BASELINE,
        "core_rules": CORE_RULES,
        "machine_readable_endpoints": MACHINE_READABLE_ENDPOINTS,
        "context_files": CONTEXT_FILES,
        "pages": pages,
    }
    (api_dir / "catalog.json").write_text(
        json.dumps(catalog, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def write_llms_full(config: dict, pages: list[dict]) -> None:
    chunks = llms_header(
        config,
        "Full LLM Context",
        "This file aggregates the Markdown pages published by the documentation site navigation.",
    )
    chunks.extend(page_chunks(pages))
    write_text_file("llms-full.txt", chunks)


def write_context_file(config: dict, output_path: str, title: str, description: str, pages: list[dict]) -> None:
    chunks = llms_header(config, title, description)
    chunks.extend(page_chunks(pages))
    write_text_file(output_path, chunks)


def is_manual_page(page: dict) -> bool:
    return "/manual/" in f"/{page['path']}"


def is_scenario_page(page: dict) -> bool:
    path = page["path"]
    return "/scenarios/" in f"/{path}" or path == "examples/index.md"


def write_llms_partitions(config: dict, pages: list[dict]) -> None:
    write_context_file(
        config,
        "llms-medium.txt",
        "Medium LLM Context",
        "Curated high-signal context for agents with limited context windows.",
        [page for page in pages if page["path"] in MEDIUM_PATHS],
    )
    write_context_file(
        config,
        "llms-manual.txt",
        "Manual LLM Context",
        "Manual pages for provider configuration, resource usage, operations, and production guidance.",
        [page for page in pages if is_manual_page(page)],
    )
    write_context_file(
        config,
        "llms-scenarios.txt",
        "Scenario LLM Context",
        "Scenario pages and example catalog context for generating runnable Terraform examples.",
        [page for page in pages if is_scenario_page(page)],
    )
    write_context_file(
        config,
        "llms-en.txt",
        "English LLM Context",
        "English documentation pages from the MkDocs navigation.",
        [page for page in pages if page["language"] == "en"],
    )
    write_context_file(
        config,
        "llms-zh.txt",
        "Chinese LLM Context",
        "Chinese documentation pages from the MkDocs navigation.",
        [page for page in pages if page["language"] == "zh"],
    )


def text_response(description: str) -> dict:
    return {
        "description": description,
        "content": {
            "text/plain": {
                "schema": {
                    "type": "string",
                }
            }
        },
    }


def json_response(description: str, schema_ref: str) -> dict:
    return {
        "description": description,
        "content": {
            "application/json": {
                "schema": {
                    "$ref": schema_ref,
                }
            }
        },
    }


def write_openapi() -> None:
    openapi = {
        "openapi": "3.1.0",
        "info": {
            "title": "Terraform Provider ZStack Documentation Discovery",
            "version": "1.1.0",
            "description": "Machine-readable discovery endpoints for the static ZStack Terraform provider documentation site. This is not the ZStack runtime API.",
        },
        "paths": {
            "/llms.txt": {
                "get": {
                    "summary": "Concise LLM index",
                    "responses": {"200": text_response("Text index for AI agents.")},
                }
            },
            "/llms-medium.txt": {
                "get": {
                    "summary": "Curated medium-size LLM context",
                    "responses": {"200": text_response("Curated high-signal Markdown context for AI agents.")},
                }
            },
            "/llms-manual.txt": {
                "get": {
                    "summary": "Manual-only LLM context",
                    "responses": {"200": text_response("Markdown aggregation of manual pages.")},
                }
            },
            "/llms-scenarios.txt": {
                "get": {
                    "summary": "Scenario and example LLM context",
                    "responses": {"200": text_response("Markdown aggregation of scenario pages and example catalog.")},
                }
            },
            "/llms-en.txt": {
                "get": {
                    "summary": "English LLM context",
                    "responses": {"200": text_response("Markdown aggregation of English documentation pages.")},
                }
            },
            "/llms-zh.txt": {
                "get": {
                    "summary": "Chinese LLM context",
                    "responses": {"200": text_response("Markdown aggregation of Chinese documentation pages.")},
                }
            },
            "/llms-full.txt": {
                "get": {
                    "summary": "Full Markdown aggregation",
                    "responses": {"200": text_response("Aggregated Markdown content from the documentation navigation.")},
                }
            },
            "/api/catalog.json": {
                "get": {
                    "summary": "Structured documentation catalog",
                    "responses": {
                        "200": json_response(
                            "Structured catalog of documentation pages and machine-readable endpoints.",
                            "#/components/schemas/Catalog",
                        )
                    },
                }
            },
            "/.well-known/mcp.json": {
                "get": {
                    "summary": "MCP discovery manifest",
                    "responses": {
                        "200": json_response(
                            "Static manifest explaining MCP availability and alternate machine-readable resources.",
                            "#/components/schemas/McpManifest",
                        )
                    },
                }
            },
            "/robots.txt": {
                "get": {
                    "summary": "Robots and AI discovery policy",
                    "responses": {"200": text_response("Robots policy with machine-readable endpoint hints.")},
                }
            },
        },
        "components": {
            "schemas": {
                "Catalog": {
                    "type": "object",
                    "required": [
                        "schema_version",
                        "site",
                        "provider_baseline",
                        "rules_baseline",
                        "machine_readable_endpoints",
                        "context_files",
                        "pages",
                    ],
                    "properties": {
                        "schema_version": {"type": "string", "example": "1.1"},
                        "site": {"$ref": "#/components/schemas/SiteInfo"},
                        "provider_baseline": {"$ref": "#/components/schemas/ProviderBaseline"},
                        "rules_baseline": {"$ref": "#/components/schemas/RulesBaseline"},
                        "core_rules": {
                            "type": "array",
                            "items": {"type": "string"},
                        },
                        "machine_readable_endpoints": {"$ref": "#/components/schemas/MachineReadableEndpoints"},
                        "context_files": {
                            "type": "array",
                            "items": {"$ref": "#/components/schemas/ContextFile"},
                        },
                        "pages": {
                            "type": "array",
                            "items": {"$ref": "#/components/schemas/Page"},
                        },
                    },
                },
                "SiteInfo": {
                    "type": "object",
                    "required": ["name", "description", "type"],
                    "properties": {
                        "name": {"type": "string"},
                        "description": {"type": "string"},
                        "type": {"type": "string", "enum": ["static_mkdocs_documentation"]},
                    },
                },
                "ProviderBaseline": {
                    "type": "object",
                    "required": ["source", "version", "terraform_required_version", "registry_url", "repository_url"],
                    "properties": {
                        "source": {"type": "string"},
                        "version": {"type": "string"},
                        "terraform_required_version": {"type": "string"},
                        "registry_url": {"type": "string", "format": "uri"},
                        "repository_url": {"type": "string", "format": "uri"},
                    },
                },
                "RulesBaseline": {
                    "type": "object",
                    "required": [
                        "docs_ai_schema_version",
                        "rules_effective_date",
                        "applies_to_provider_version",
                        "re_evaluate_when",
                    ],
                    "properties": {
                        "docs_ai_schema_version": {"type": "string"},
                        "rules_effective_date": {"type": "string", "format": "date"},
                        "applies_to_provider_version": {"type": "string"},
                        "re_evaluate_when": {
                            "type": "array",
                            "items": {"type": "string"},
                        },
                    },
                },
                "MachineReadableEndpoints": {
                    "type": "object",
                    "additionalProperties": {"type": "string"},
                    "properties": {
                        "llms": {"type": "string"},
                        "llms_medium": {"type": "string"},
                        "llms_manual": {"type": "string"},
                        "llms_scenarios": {"type": "string"},
                        "llms_english": {"type": "string"},
                        "llms_chinese": {"type": "string"},
                        "llms_full": {"type": "string"},
                        "robots": {"type": "string"},
                        "mcp_manifest": {"type": "string"},
                        "openapi": {"type": "string"},
                        "catalog": {"type": "string"},
                    },
                },
                "ContextFile": {
                    "type": "object",
                    "required": ["path", "scope", "language", "description", "recommended_when"],
                    "properties": {
                        "path": {"type": "string"},
                        "scope": {"type": "string"},
                        "language": {"type": "string", "enum": ["neutral", "multi", "en", "zh"]},
                        "description": {"type": "string"},
                        "recommended_when": {"type": "string"},
                    },
                },
                "Page": {
                    "type": "object",
                    "required": ["title", "path", "url", "language", "section"],
                    "properties": {
                        "title": {"type": "string"},
                        "path": {"type": "string"},
                        "url": {"type": "string"},
                        "language": {"type": "string", "enum": ["neutral", "en", "zh"]},
                        "section": {"type": "string"},
                    },
                },
                "McpManifest": {
                    "type": "object",
                    "required": ["schema_version", "name", "status", "mcp_servers", "resources"],
                    "properties": {
                        "schema_version": {"type": "string"},
                        "name": {"type": "string"},
                        "description": {"type": "string"},
                        "status": {"type": "string"},
                        "mcp_servers": {
                            "type": "array",
                            "items": {"type": "object"},
                        },
                        "note": {"type": "string"},
                        "resources": {
                            "type": "object",
                            "additionalProperties": {"type": "string"},
                        },
                    },
                },
            }
        },
    }
    (DOCS / "openapi.json").write_text(
        json.dumps(openapi, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


def main() -> None:
    config = load_config()
    pages = [p for p in walk_nav(config.get("nav", [])) if p["path"].endswith(".md")]
    write_llms_index(config)
    write_catalog(config, pages)
    write_llms_full(config, pages)
    write_llms_partitions(config, pages)
    write_openapi()


if __name__ == "__main__":
    main()
