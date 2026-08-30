pragma Singleton
import Quickshell

Singleton {
  function getBattery(percentage: int, charging: bool): string {
    if (charging) {
      if (percentage >= 90) return "󰂅"
      if (percentage >= 80) return "󰂋"
      if (percentage >= 70) return "󰂊"
      if (percentage >= 60) return "󰢞"
      if (percentage >= 50) return "󰂉"
      if (percentage >= 40) return "󰢝"
      if (percentage >= 30) return "󰂈"
      if (percentage >= 20) return "󰂇"
      if (percentage >= 10) return "󰂆"
      return "󰢜"
    }

    if (percentage >= 90) return "󰁹"
    if (percentage >= 80) return "󰂂"
    if (percentage >= 70) return "󰂁"
    if (percentage >= 60) return "󰂀"
    if (percentage >= 50) return "󰁿"
    if (percentage >= 40) return "󰁾"
    if (percentage >= 30) return "󰁽"
    if (percentage >= 20) return "󰁼"
    if (percentage >= 10) return "󰁻"
    return "󰁺"
  }

  function weatherIconCode(code, isDay: bool): string {
    switch (String(code)) {
      case "113":
      return isDay ? "" : ""  // clear
      case "116":
      return isDay ? "" : ""  // partly cloudy
      case "119":
      return ""  // cloudy
      case "122":
      return ""  // very cloudy
      case "143":
      case "248":
      case "260":
      return ""  // fog
      case "176":
      case "263":
      case "353":
      return isDay ? "" : ""  // light showers
      case "179":
      case "182":
      case "185":
      case "281":
      case "284":
      case "311":
      case "314":
      case "317":
      case "350":
      case "362":
      case "365":
      case "374":
      case "377":
      return isDay ? "" : ""  // light sleet showers
      case "200":
      case "386":
      return ""  // thundery showers
      case "227":
      case "320":
      return isDay ? "" : ""  // light snow
      case "230":
      case "329":
      case "332":
      case "338":
      return ""  // heavy snow
      case "266":
      case "293":
      case "296":
      return isDay ? "" : ""  // light rain
      case "299":
      case "305":
      case "356":
      return ""  // heavy showers
      case "302":
      case "308":
      case "359":
      return ""  // heavy rain
      case "323":
      case "326":
      case "368":
      return isDay ? "" : ""  // light snow showers
      case "335":
      case "371":
      case "395":
      return ""  // heavy snow showers
      case "389":
      return ""  // thunderstorm with heavy rain
      case "392":
      return isDay ? "" : ""  // thunderstorm with snow showers
      default:
      return ""  // unknown
    }
  }
}
