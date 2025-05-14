import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="conversation"
export default class extends Controller {
  static targets = [ "messages", "textArea" ]
  static values = {
      unreadMessageDomId: String
    }

  connect() {
    this.setScrollPosition();
    this.observer = new MutationObserver((mutations) => {
      const hasNewNodes = mutations.some(mutation =>
        mutation.type === 'childList' && mutation.addedNodes.length > 0
      );

      if (hasNewNodes) {
        this.setScrollPosition();
      }
    });

    this.observer.observe(this.messagesTarget, {
      childList: true,
      subtree: true
    });
  }

  disconnect() {
    if (this.observer) {
      this.observer.disconnect();
    }
  }

  setScrollPosition() {
    if (this.unreadMessageDomIdValue) {
      const targetElement = document.getElementById(this.unreadMessageDomIdValue)

      if (targetElement) {
        targetElement.scrollIntoView({ behavior: "smooth", block: "start" });
        return;
      }
    }

    // Fallback to scrolling to bottom
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight - this.messagesTarget.clientHeight 
  }

  submitForm(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault();
      const form = event.target.closest("form");
      form.submit();
    }
  }
}
