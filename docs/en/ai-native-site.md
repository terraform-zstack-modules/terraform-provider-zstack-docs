# AI Native Entry Points

This documentation site publishes entry points for both humans and AI agents.
Repository files such as `AGENTS.md`, skills, and examples are useful for local
developer tools. After the site is published, AI agents should prefer the stable
URLs below for retrieval.

| Entry Point | Purpose |
|---|---|
| [`/llms.txt`](/llms.txt) | Concise index for first-pass agent reading. |
| [`/llms-medium.txt`](/llms-medium.txt) | Curated medium-size context for agents with limited context windows. |
| [`/llms-manual.txt`](/llms-manual.txt) | Manual-only aggregation for provider configuration, resource usage, and operations. |
| [`/llms-scenarios.txt`](/llms-scenarios.txt) | Scenario and example aggregation for generating runnable Terraform examples. |
| [`/llms-en.txt`](/llms-en.txt) | English documentation aggregation. |
| [`/llms-zh.txt`](/llms-zh.txt) | Chinese documentation aggregation. |
| [`/llms-full.txt`](/llms-full.txt) | Full Markdown context aggregated from MkDocs navigation. |
| [`/api/catalog.json`](/api/catalog.json) | Structured page catalog with language, path, and discovery endpoints. |
| [`/openapi.json`](/openapi.json) | OpenAPI specification for documentation discovery endpoints only; it is not the ZStack runtime API. |
| [`/.well-known/mcp.json`](/.well-known/mcp.json) | Static MCP discovery manifest stating that the site does not expose a live MCP server. |
| [`/robots.txt`](/robots.txt) | Crawler rules and AI discovery hints. |
| [`/sitemap.xml`](/sitemap.xml) | Traditional SEO and page discovery entry point. |

Recommended reading order:

1. Read `/llms.txt` first to understand the site scope, provider version, and key constraints.
2. Read `/api/catalog.json` for the structured page catalog.
3. Read `/llms-medium.txt` when context is limited, or `/llms-manual.txt` / `/llms-scenarios.txt` for focused retrieval.
4. Read `/llms-full.txt` when full context is needed and page-by-page crawling would risk missing navigation pages.
5. Before generating Terraform code, prefer the matching English or Chinese manual page and runnable examples.

The `LLMs:` and `API-Catalog:` fields in `/robots.txt` are non-standard
discovery hints and may be ignored by mainstream crawlers. The same resources
are also exposed through HTML `<head>` links and `/api/catalog.json`.

These endpoints describe the Terraform Provider ZStack documentation site. They
do not represent the business API of a ZStack management node. For ZStack API
calls, use the ZStack product API documentation and provider implementation as
the source of truth.
