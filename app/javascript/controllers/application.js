import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

document.addEventListener("turbo:load", function () {
  document.querySelectorAll("trix-editor").forEach((editor) => {
    editor.addEventListener("trix-change", function () {
      let text = editor.editor.getDocument().toString().trim();
      let lines = text.split("\n").filter((line) => line.trim() !== "");
      if (lines.length > 30) {
        alert("Limit 30 linijek tekstu został osiągnięty");
        editor.editor.loadHTML(lines.slice(0, 30).join("<br />"));
      }
    });
  });
});

export { application };
