import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="weather"
export default class extends Controller {
  static targets = ["form", "input", "temp8", "temp14", "temp20", "prev8", "prev14",
                    "prev20", "wind8", "wind14", "wind20", "tend8", "tend14", "tend20"]
  connect() {
    //console.log(this.element)
    //console.log(this.formTarget)
    //console.log(this.inputTarget)
  }
  insertResult(event){
      event.preventDefault()
      const city = this.inputTarget.value
      const url = `https://geocoding-api.open-meteo.com/v1/search?name=${city}&count=1&format=json`
      const options = {
          method: "GET",
          headers: { "Accept": "application/json"}
      }
      fetch(url, options)
      .then(response => response.json())
      .then((data)=> {
          this.findWeather(data)
      })
  }
  findWeather(data){
      const locale = document.querySelector('table').dataset.locale
      let long = data["results"][0]["longitude"]
      let lat = data["results"][0]["latitude"]
      const weatherUrl = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${long}&hourly=temperature_2m,precipitation_probability,weather_code,wind_speed_10m&forecast_days=1`
      const options = {
          method: "GET",
          headers: { "Accept": "application/json" },
      }
      fetch(weatherUrl, options)
          .then(response => response.json())
          .then((data) => {
              this.tend8Target.innerHTML = this.convertWeatherCode(data["hourly"]["weather_code"][8], locale)
              this.tend14Target.innerHTML = this.convertWeatherCode(data["hourly"]["weather_code"][14], locale)
              this.tend20Target.innerHTML = this.convertWeatherCode(data["hourly"]["weather_code"][20], locale)
              this.temp8Target.innerHTML = data["hourly"]["temperature_2m"][8]
              this.temp14Target.innerHTML = data["hourly"]["temperature_2m"][14]
              this.temp20Target.innerHTML = data["hourly"]["temperature_2m"][20]
              this.prev8Target.innerHTML = data["hourly"]["precipitation_probability"][8]
              this.prev14Target.innerHTML = data["hourly"]["precipitation_probability"][14]
              this.prev20Target.innerHTML = data["hourly"]["precipitation_probability"][20]
              this.wind8Target.innerHTML = data["hourly"]["wind_speed_10m"][8]
              this.wind14Target.innerHTML = data["hourly"]["wind_speed_10m"][14]
              this.wind20Target.innerHTML = data["hourly"]["wind_speed_10m"][20]
          })
  }
  convertWeatherCode(code, locale){
      switch (code) {
          case 0:
            return locale === "fr" ? "Ciel dégagé" : "Clear sky"
          case 1:
            return locale === "fr" ? "Ciel plutôt dégagé" : "Mainly clear"
          case 2:
            return locale === "fr" ? "Ciel partiellement couvert" : "Partly cloudy"
          case 3:
            return locale === "fr" ? "Ciel couvert" : "Overcast"
          case (45 || 48):
            return locale === "fr" ? "Brouillard" : "Fog"
          case 51:
            return locale === "fr" ? "Bruine légère" : "Light drizzle"
          case 52:
            return locale === "fr" ? "Bruine modérée" : "Moderate drizzle"
          case 53:
            return locale === "fr" ? "Bruine intense" : "Dense drizzle"
          case (56 || 57):
            return locale === "fr" ? "Bruine verglaçante" : "Freezing Drizzle"
          case 61:
            return locale === "fr" ? "Pluie légère" : "Slight rain"
          case 63:
            return locale === "fr" ? "Pluie modérée" : "Moderate rain"
          case 65:
            return locale === "fr" ? "Pluie intense" : "Heavy rain"
          case (66 || 67):
            return locale === "fr" ? "Pluie verglaçante" : "Freezing Rain"
          case 71:
            return locale === "fr" ? "Neige légère" : "Slight snow fall"
          case 73:
            return locale === "fr" ? "Neige modérée" : "Moderate snow fall"
          case 75:
            return locale === "fr" ? "Neige intense" : "Heavy snow fall"
          case 77:
            return locale === "fr" ? "Grains de neige" : "Snow grains"
          case 80:
            return locale === "fr" ? "Légères averses de pluie" : "Slight rain showers"
          case 81:
            return locale === "fr" ? "Averses de pluie modérées" : "Moderate rain showers"
          case 82:
            return locale === "fr" ? "Averses de pluie intenses" : "Heavy rain showers"
          case 85:
            return locale === "fr" ? "Légères averses de neige" : "Slight snow showers"
          case 86:
            return locale === "fr" ? "Averses de neige intenses" : "Heavy snow showers"
          case 95:
            return locale === "fr" ? "Orage" : "Thunderstorm"
          case 96:
            return locale === "fr" ? "Orage avec légère grêle" : "Thunderstorm with slight hail"
          case 98:
            return locale === "fr" ? "Orage avec grêle intense" : "Thunderstorm with heavy hail"
      }
  }
}
