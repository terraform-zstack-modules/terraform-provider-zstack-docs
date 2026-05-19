# AI 原生入口

本文档站同时发布面向人类和面向 AI agent 的入口。仓库中的
`AGENTS.md`、skills 和示例适合本地开发工具读取；站点发布后，AI
agent 应优先从以下稳定 URL 获取上下文。

| 入口 | 用途 |
|---|---|
| [`/llms.txt`](/llms.txt) | 精简索引，适合作为第一次读取入口。 |
| [`/llms-full.txt`](/llms-full.txt) | 按 MkDocs 导航聚合的全文 Markdown 上下文。 |
| [`/api/catalog.json`](/api/catalog.json) | 结构化页面目录、语言、路径和 AI 发现入口。 |
| [`/openapi.json`](/openapi.json) | 仅描述文档发现端点的 OpenAPI 规范，不是 ZStack 运行时 API。 |
| [`/.well-known/mcp.json`](/.well-known/mcp.json) | 静态 MCP 发现清单，说明当前站点未暴露实时 MCP server。 |
| [`/robots.txt`](/robots.txt) | 爬虫规则和 AI 发现提示。 |
| [`/sitemap.xml`](/sitemap.xml) | 传统 SEO 和页面发现入口。 |

推荐读取顺序：

1. 先读 `/llms.txt` 判断站点范围、provider 版本和关键约束。
2. 再读 `/api/catalog.json` 获取结构化页面目录。
3. 需要完整上下文时读取 `/llms-full.txt`，避免逐页抓取遗漏导航内页面。
4. 生成 Terraform 代码前，优先查阅对应中文或英文手册章节和可运行示例。

这些端点描述的是 Terraform Provider ZStack 文档站，不代表 ZStack
管理节点的业务 API。若要调用 ZStack API，请以 ZStack 产品 API 文档和
provider 实现为准。
