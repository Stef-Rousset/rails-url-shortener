import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-more-transactions"
export default class extends Controller {
  static targets = ['input']
  connect() {
    //console.log(this.element)
    //console.log(this.inputTarget)
  }

  update(){
    // on each click on arrow, increment by 1 the value of input count
    let number = parseInt(this.inputTarget.value, 10)
    number += 1
    this.inputTarget.value = number.toString()
  }
}
