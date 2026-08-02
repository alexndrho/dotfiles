pragma Singleton
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Io
import qs.helpers

Singleton {
  id: root

  readonly property UPowerDevice device: UPower.displayDevice
  readonly property int percentage: Math.round(device.percentage * 100)
  readonly property bool charging: device.ready && !UPower.onBattery
  readonly property bool critical: device.ready && percentage <= 20 && !charging
  readonly property string icon: IconUtils.getBattery(percentage, charging)

  property bool alreadyNotifiedCritical: false

  onCriticalChanged: {
    if (critical && !alreadyNotifiedCritical) {
      alreadyNotifiedCritical = true
      criticalNotifyProc.running = true
    } else if (!critical) {
      alreadyNotifiedCritical = false
    }
  }

  Process {
    id: criticalNotifyProc
    command: ["notify-send", "Low Battery", `${root.percentage}% battery remaining.`]
  }
}
