import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cards"
export default class extends Controller {

  connect() {
    //console.log(this.element)
  }
  toggleText(event){
    const img = event.currentTarget.children[0]
    const textOn = event.currentTarget.children[1]
    const textOff = event.currentTarget.children[2]
    img.classList.toggle("hidden")
    textOn.classList.toggle("hidden")
    textOff.classList.toggle("hidden")
    //img.classList.toggle("invert")
    event.currentTarget.classList.toggle("bg-beige")
    event.currentTarget.classList.toggle("bg-darkblue")
  }
}
