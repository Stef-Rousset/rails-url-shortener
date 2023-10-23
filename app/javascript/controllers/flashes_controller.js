import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flashes"
export default class extends Controller {
  static targets = ["flash"]

  connect() {
    //console.log(this.element)
    //console.log(this.flashTarget)
  }
  close(){
    this.flashTarget.style.display = "none"
  }
}
