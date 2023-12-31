import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flashes"
export default class extends Controller {
  static targets = ["flash"]

  connect() {
    //console.log(this.element)
    //console.log(this.flashTarget)
    setTimeout(() => {
      this.flashTarget.classList.add('animate-flashdisappear')
    }, 2000);
  }
  close(){
    this.flashTarget.style.display = "none"
  }
}
