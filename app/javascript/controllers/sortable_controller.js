import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";
import Sortable from "sortablejs";

export default class extends Controller {
  static values = { url: String };

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this),
      animation: 150,
    });
  }

  disconnect() {
    this.sortable.destroy();
  }

  onEnd(event) {
    const { newIndex, item } = event;
    const id = item.dataset["sortableId"];
    const url = this.urlValue.replace(":id", id);
    console.log(url);

    patch(url, {
      body: JSON.stringify({ position: newIndex }),
    });
  }
}
