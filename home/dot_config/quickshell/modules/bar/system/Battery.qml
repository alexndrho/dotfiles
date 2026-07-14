import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

import qs.config
import qs.components

Item {
  id: battery
  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight

  readonly property UPowerDevice device: UPower.displayDevice
  readonly property int pct: Math.round(device.percentage * 100)
  readonly property bool charging: !UPower.onBattery

  readonly property string icon: {
    if (charging) {
      if (pct == 100) return "󰂅"
      if (pct >= 90) return "󰂋"
      if (pct >= 80) return "󰂊"
      if (pct >= 70) return "󰢞"
      if (pct >= 60) return "󰂉"
      if (pct >= 50) return "󰢝"
      if (pct >= 40) return "󰂈"
      if (pct >= 30) return "󰂇"
      if (pct >= 20) return "󰂆"
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

  readonly property bool critical: battery.pct <= 20 && !battery.charging

  RowLayout {
    id: content
    spacing: Theme.spacingXs

    StyledText {
      text: battery.icon
      font.pixelSize: 16
      color: battery.critical ? Theme.yellow : Theme.fg0
    }

    // StyledText {
    //   color: battery.critical ? Theme.yellow : Theme.fg0
    //   text: battery.pct + "%"
    // }
  }
}
