"""MkDocs hooks for AI-readable site discovery files."""

from __future__ import annotations

import importlib.util
from pathlib import Path

from mkdocs.structure.files import File, Files

ROOT = Path(__file__).resolve().parents[1]
GENERATOR_PATH = ROOT / "scripts" / "generate-ai-site-files.py"
MCP_MANIFEST_PATH = ROOT / "docs" / ".well-known" / "mcp.json"


def _load_generator():
    spec = importlib.util.spec_from_file_location("generate_ai_site_files", GENERATOR_PATH)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Cannot load {GENERATOR_PATH}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def on_pre_build(*, config) -> None:
    _load_generator().main()


def on_files(files: Files, *, config) -> Files:
    if MCP_MANIFEST_PATH.exists():
        files.append(
            File.generated(
                config,
                ".well-known/mcp.json",
                content=MCP_MANIFEST_PATH.read_text(encoding="utf-8"),
            )
        )
    return files


def on_post_build(*, config) -> None:
    if not MCP_MANIFEST_PATH.exists():
        return
    target = Path(config.site_dir) / ".well-known" / "mcp.json"
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(MCP_MANIFEST_PATH.read_text(encoding="utf-8"), encoding="utf-8")
