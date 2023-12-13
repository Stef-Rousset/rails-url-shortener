import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="back-to-top"
export default class extends Controller {
  static targets = ["button", "body"]
  connect() {
    //console.log(this.element)
    //console.log(this.buttonTarget)
    //console.log(this.bodyTarget)
  }

  showButton(){
    const body = this.bodyTarget
    const button = this.buttonTarget
    if (body.scrollTop >= 150){  //scrollTop renvoit le nb de px dont l'élement est scrollé
      button.classList.remove('hidden')
    } else if (body.scrollTop <= 150){
      button.classList.add('hidden')
    }
  }
  upToTop(){
    const body = this.bodyTarget
    body.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  }
}
