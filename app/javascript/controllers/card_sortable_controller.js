import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";
import Sortable from "sortablejs";

export default class extends Controller {
  static values = { url: String };

  connect() {
    this.cardSortable = Sortable.create(this.element, {
      group: "shared",
      onEnd: this.onEnd.bind(this),
      animation: 150,
    });
  }

  disconnect() {
    this.cardSortable.destroy();
  }

  onEnd(event) {
    const { newIndex, item, to } = event;
    const id = item.dataset["cardSortableId"];
    const url = this.urlValue.replace(":id", id);

    const randomId = to.dataset.cardSortableUrlValue;
    const newListId = parseInt(randomId.match(/\/lists\/(\d+)\//)?.[1], 10);

    patch(url, {
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ new_list_id: newListId, position: newIndex }),
    });
  }
}
