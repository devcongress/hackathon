import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.menu = document.getElementById("menu");
    this.close();
  }

  open() {
    this.menu.classList.remove("hidden");
  }

  close() {
    this.menu.classList.add("hidden");
  }
}
