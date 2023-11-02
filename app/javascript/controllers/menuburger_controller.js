import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menuburger"
export default class extends Controller {
  static targets = ['menulist', 'spanone', 'spantwo', 'spanthree']
  connect() {
    //console.log(this.element)
    //console.log(this.menulistTarget)
    //console.log(this.spanTargets)
  }
  toggle() {
    const list = this.menulistTarget
    const one = this.spanoneTarget
    const two = this.spantwoTarget
    const three = this.spanthreeTarget
    if (list.classList.contains("translate-y-300") || list.classList.contains("animate-burgerout")) {
      list.classList.remove("translate-y-300")
      list.classList.remove("animate-burgerout")
      list.classList.add("animate-burgerin")
    } else {
      list.classList.remove("animate-burgerin")
      list.classList.add("animate-burgerout")
    }
    if(!two.classList.contains("hidden")){
      two.classList.add('hidden')
    }else{
      two.classList.remove('hidden')
    }
    if (!one.classList.contains("animate-diagone")) {
      one.classList.add('animate-diagone')
      one.classList.remove('animate-diagoneout')
    } else {
      one.classList.remove('animate-diagone')
      one.classList.add('animate-diagoneout')
    }
    if (!three.classList.contains("animate-diagtwo")) {
      three.classList.add('animate-diagtwo')
      three.classList.remove('animate-diagtwoout')
    } else {
      three.classList.remove('animate-diagtwo')
      three.classList.add('animate-diagtwoout')
    }

    //spans.forEach(span => {
    //  if (span.classList.contains("bg-white")) {
    //    span.classList.remove("bg-white")
    //    span.classList.add("bg-beige")
    //  } else if (span.classList.contains("bg-beige")) {
    //    span.classList.remove("bg-beige")
    //    span.classList.add("bg-white")
    //  }
    //})
  }
}
