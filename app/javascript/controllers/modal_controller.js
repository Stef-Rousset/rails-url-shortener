import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ['cross']

  connect() {
    //console.log(this.element)
    //console.log(this.crossTarget)
  }
  close(){
    this.element.style.display = "none"
  }
}
