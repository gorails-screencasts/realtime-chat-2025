import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="conversation"
export default class extends Controller {
  static targets = [ "messages", "textArea" ]

  connect() {
    this.setScrollPosition();
    this.messagesTarget.addEventListener("DOMNodeInserted", () => this.setScrollPosition())
  }

  setScrollPosition() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight - this.messagesTarget.clientHeight 
  }

  submitForm(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault();
      const form = event.target.closest("form");
      form.requestSubmit();
      form.reset();
    }
  }
}
