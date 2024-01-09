import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flashes"
export default class extends Controller {
  static targets = ["flash"]

  connect() {
    //console.log(this.element)
    setTimeout(() => {
      this.flashTarget.classList.add('animate-flashdisappear')
    }, 2000);
  }
  close(){
    this.flashTarget.style.display = "none"
  }
}
