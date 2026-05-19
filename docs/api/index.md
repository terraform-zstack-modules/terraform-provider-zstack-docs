# Machine-Readable API

This static documentation site exposes machine-readable discovery files for AI
agents and retrieval systems. These endpoints describe the documentation site,
not the ZStack runtime API.

| Endpoint | Purpose |
|---|---|
| [`/llms.txt`](/llms.txt) | Concise LLM-oriented site index. |
| [`/llms-medium.txt`](/llms-medium.txt) | Curated medium-size context for agents with limited context windows. |
| [`/llms-manual.txt`](/llms-manual.txt) | Manual-only Markdown aggregation. |
| [`/llms-scenarios.txt`](/llms-scenarios.txt) | Scenario and example Markdown aggregation. |
| [`/llms-en.txt`](/llms-en.txt) | English-only Markdown aggregation. |
| [`/llms-zh.txt`](/llms-zh.txt) | Chinese-only Markdown aggregation. |
| [`/llms-full.txt`](/llms-full.txt) | Full Markdown aggregation generated from MkDocs navigation. |
| [`/api/catalog.json`](/api/catalog.json) | Structured JSON catalog of site pages and AI discovery endpoints. |
| [`/openapi.json`](/openapi.json) | OpenAPI description for documentation discovery endpoints. |
| [`/.well-known/mcp.json`](/.well-known/mcp.json) | Static MCP discovery manifest. |
| [`/robots.txt`](/robots.txt) | Crawler and AI discovery hints. |

`/robots.txt` includes non-standard AI discovery hints for simple crawlers. The
same resources are also exposed through HTML `<head>` links and
`/api/catalog.json`.

For human-readable documentation, start from the [English manual](../en/manual/index.md)
or [Chinese manual](../zh/manual/index.md).
