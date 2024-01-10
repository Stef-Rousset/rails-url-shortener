import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cards"
export default class extends Controller {
   static targets = ["firstdiv", "firstp", "seconddiv", "secondp"]

  connect() {
    //console.log(this.element)
    // manage appearance of the first 2 cards in homepage (see back_to_top for other divs)
    if (this.firstdivTarget) {
        const firstdiv = this.firstdivTarget
        const firstp = this.firstpTarget
        const seconddiv = this.seconddivTarget
        const secondp = this.secondpTarget
        firstdiv.classList.add("animate-animatediv")
        firstp.classList.add("animate-animatep")
        setTimeout(() => {
          seconddiv.classList.add("animate-animatediv")
          secondp.classList.add("animate-animatep")
        }, 500);
    }
  }
}
