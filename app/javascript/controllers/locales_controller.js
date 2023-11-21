import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="locales"
export default class extends Controller {
  static targets = ["select"]
  connect() {
    //console.log(this.element)
    //console.log(this.selectTarget)
  }
  changeLanguage(event){
    event.preventDefault()
    const language = this.selectTarget.value
    const url = new URL(window.location)
    const parts = url.pathname.split('/') // parts is an array like ["", "fr", "spell_checker"]
    // if locale is fr or if there is no locale yet => change for en
    if (parts.includes('fr') || !parts.includes('en')){
      parts.splice(1, 1, language) // we replace at indice 1
      url.pathname = parts.join('/')
      window.location = url.href  // reload the page with new url
    // if locale is en
    }else if (parts.includes('en')){
      parts.splice(1, 1, language)
      url.pathname = parts.join('/')
      window.location = url.href
    }
  }
}
