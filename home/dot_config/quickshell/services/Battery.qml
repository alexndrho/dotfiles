pragma Singleton
import Quickshell
import Quickshell.Services.UPower

Singleton {
  readonly property UPowerDevice device: UPower.displayDevice
  readonly property int pct: Math.round(device.percentage * 100)
  readonly property bool charging: !UPower.onBattery
  readonly property bool critical: battery.pct <= 20 && !battery.charging

  readonly property string icon: {
    if (charging) {
      if (pct >= 90) return "󰂅"
      if (pct >= 80) return "󰂋"
      if (pct >= 70) return "󰂊"
      if (pct >= 60) return "󰢞"
      if (pct >= 50) return "󰂉"
      if (pct >= 40) return "󰢝"
      if (pct >= 30) return "󰂈"
      if (pct >= 20) return "󰂇"
      if (pct >= 10) return "󰂆"
      return "󰢜"
    }

    if (pct >= 90) return "󰁹"
    if (pct >= 80) return "󰂂"
    if (pct >= 70) return "󰂁"
    if (pct >= 60) return "󰂀"
    if (pct >= 50) return "󰁿"
    if (pct >= 40) return "󰁾"
    if (pct >= 30) return "󰁽"
    if (pct >= 20) return "󰁼"
    if (pct >= 10) return "󰁻"
    return "󰁺"
  }
}
