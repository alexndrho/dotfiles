pragma Singleton
import Quickshell
import Quickshell.Services.UPower

Singleton {
  readonly property UPowerDevice device: UPower.displayDevice
  readonly property int percent: Math.round(device.percentage * 100)
  readonly property bool charging: !UPower.onBattery
  readonly property bool critical: percent <= 20 && !charging

  readonly property string icon: {
    if (charging) {
      if (percent >= 90) return "󰂅"
      if (percent >= 80) return "󰂋"
      if (percent >= 70) return "󰂊"
      if (percent >= 60) return "󰢞"
      if (percent >= 50) return "󰂉"
      if (percent >= 40) return "󰢝"
      if (percent >= 30) return "󰂈"
      if (percent >= 20) return "󰂇"
      if (percent >= 10) return "󰂆"
      return "󰢜"
    }

    if (percent >= 90) return "󰁹"
    if (percent >= 80) return "󰂂"
    if (percent >= 70) return "󰂁"
    if (percent >= 60) return "󰂀"
    if (percent >= 50) return "󰁿"
    if (percent >= 40) return "󰁾"
    if (percent >= 30) return "󰁽"
    if (percent >= 20) return "󰁼"
    if (percent >= 10) return "󰁻"
    return "󰁺"
  }
}
