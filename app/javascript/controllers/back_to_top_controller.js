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
    const scrolledPixs = body.scrollTop
    const button = this.buttonTarget
    if (scrolledPixs >= 150){  //scrollTop renvoit le nb de px dont l'élement est scrollé
      button.classList.remove('hidden')
    } else if (scrolledPixs <= 150){
      button.classList.add('hidden')
    }
    // depending on scroll, make home page divs appear
    if (scrolledPixs > 900){
      document.getElementById("fifthdiv").classList.add("animate-animatediv")
      document.getElementById("fifthp").classList.add("animate-animatep")
    }else if (scrolledPixs > 600){
      document.getElementById("fourthdiv").classList.add("animate-animatediv")
      document.getElementById("fourthp").classList.add("animate-animatep")
    }else if (scrolledPixs > 300) {
      document.getElementById("thirddiv").classList.add("animate-animatediv")
      document.getElementById("thirdp").classList.add("animate-animatep")
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
