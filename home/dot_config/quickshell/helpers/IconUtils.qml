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
}
