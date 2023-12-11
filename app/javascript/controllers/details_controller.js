import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="details"
export default class extends Controller {
  static targets = ['button']
  connect() {
    //console.log(this.element)
    //console.log(this.buttonTargets)
  }
  show(event) {
    const buttons = this.buttonTargets
    buttons.forEach(function (button){
        if(button == event.currentTarget) {
          button.nextElementSibling.hidden = false
          button.hidden = true
        }
      }
    )
  }
  hide(event){
    const buttons = this.buttonTargets
    buttons.forEach(function (button) {
      if (button == event.currentTarget) {
          button.parentElement.previousElementSibling.hidden = false
          button.parentElement.hidden = true
      }
    })
  }
}
