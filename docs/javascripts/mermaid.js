function initializeMermaid() {
  if (typeof mermaid === "undefined") {
    return;
  }

  mermaid.initialize({
    startOnLoad: false,
    theme: document.body.getAttribute("data-md-color-scheme") === "slate" ? "dark" : "default",
  });

  mermaid.run({
    nodes: document.querySelectorAll(".mermaid"),
  });
}

if (typeof document$ !== "undefined") {
  document$.subscribe(initializeMermaid);
} else {
  document.addEventListener("DOMContentLoaded", initializeMermaid);
}
