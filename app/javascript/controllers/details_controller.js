import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="details"
export default class extends Controller {
  static targets = ['button']
  connect() {
    //console.log(this.element)
    //console.log(this.buttonTargets)
  }
  // show div containing details of transaction and 'Voir moins' btn, and hide 'Voir plus' button
  show(event) {
    const buttons = this.buttonTargets
    buttons.forEach(function (button){
        if(button == event.currentTarget) {
            button.nextElementSibling.hidden = false // div
            button.hidden = true
        }
      }
    )
  }
  // hide div containing details of transaction and 'Voir moins' btn, and show 'Voir plus' button
  hide(event){
    const buttons = this.buttonTargets
    buttons.forEach(function (button) {
      if (button == event.currentTarget) {
          button.parentElement.previousElementSibling.hidden = false // 'Voir plus' btn
          button.parentElement.hidden = true // div
      }
    })
  }
}
