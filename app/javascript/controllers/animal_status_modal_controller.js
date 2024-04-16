import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="animal-status-modal"
export default class extends Controller {
  connect() {
  }

  initialize() { 
    this.element.setAttribute("data-action", "click->animal-status-modal#showModal")
  }

  showModal(event) {
    event.preventDefault()
    this.url = this.element.getAttribute("href")
    console.log(this.url)
    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html",
      }
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}
