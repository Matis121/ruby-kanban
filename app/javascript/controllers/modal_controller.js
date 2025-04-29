import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    window.addEventListener("popstate", this.clearModalContent.bind(this));
  }

  disconnect() {
    window.removeEventListener("popstate", this.clearModalContent.bind(this));
  }

  open(event) {
    event.preventDefault();

    const url = this.element.href;

    history.pushState({}, "", url);

    Turbo.visit(url, {
      action: "replace",
      frame: "modal",
    });
  }

  close(event) {
    event.preventDefault();
    history.back();
  }

  closeIfSuccessful(event) {
    event.preventDefault();
    history.back();
    if (event.detail.success) {
      this.clearModalContent();
    }
  }

  clearModalContent() {
    const modal = document.getElementById("modal");
    if (modal) {
      modal.innerHTML = "";
    }
  }
}
