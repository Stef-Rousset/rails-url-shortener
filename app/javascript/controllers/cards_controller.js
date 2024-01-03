import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cards"
export default class extends Controller {
   static targets = ["firstdiv", "firstp", "seconddiv", "secondp"]

  connect() {
    //console.log(this.element)
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
