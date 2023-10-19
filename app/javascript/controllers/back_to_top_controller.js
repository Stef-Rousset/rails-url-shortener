import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="back-to-top"
export default class extends Controller {
  static targets = ["button", "main"]
  connect() {
    //console.log(this.element)
    //console.log(this.buttonTarget)
    //console.log(this.mainTarget)
  }

  showButton(){
    const main = this.mainTarget
    const button = this.buttonTarget
    if (main.scrollTop >= 150){  //scrollTop renvoit le nb de px dont l'élement est scrollé
      button.classList.remove('hidden')
    } else if (main.scrollTop <= 150){
      button.classList.add('hidden')
    }
  }
  upToTop(){
    const main = this.mainTarget
    main.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  }
}
