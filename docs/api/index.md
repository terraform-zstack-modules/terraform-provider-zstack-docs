# Machine-Readable API

This static documentation site exposes machine-readable discovery files for AI
agents and retrieval systems. These endpoints describe the documentation site,
not the ZStack runtime API.

| Endpoint | Purpose |
|---|---|
| [`/llms.txt`](/llms.txt) | Concise LLM-oriented site index. |
| [`/llms-full.txt`](/llms-full.txt) | Full Markdown aggregation generated from MkDocs navigation. |
| [`/api/catalog.json`](/api/catalog.json) | Structured JSON catalog of site pages and AI discovery endpoints. |
| [`/openapi.json`](/openapi.json) | OpenAPI description for documentation discovery endpoints. |
| [`/.well-known/mcp.json`](/.well-known/mcp.json) | Static MCP discovery manifest. |
| [`/robots.txt`](/robots.txt) | Crawler and AI discovery hints. |

For human-readable documentation, start from the [English manual](../en/manual/index.md)
or [Chinese manual](../zh/manual/index.md).
