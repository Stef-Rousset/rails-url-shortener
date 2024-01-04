import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="animate-about-page"
export default class extends Controller {
  static targets = ["ressource", "stack"]
  connect() {
    //console.log(this.element)
    const ressource = this.ressourceTarget
    const stack = this.stackTarget
    ressource.classList.add("animate-aboutpagediv")
    setTimeout(() => {
      stack.classList.add("animate-aboutpagediv")
    }, 500);
  }
}
