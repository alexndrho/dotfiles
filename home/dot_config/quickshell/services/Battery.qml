pragma Singleton
import Quickshell
import Quickshell.Services.UPower
import qs.helpers

Singleton {
  readonly property UPowerDevice device: UPower.displayDevice
  readonly property int percentage: Math.round(device.percentage * 100)
  readonly property bool charging: !UPower.onBattery
  readonly property bool critical: percentage <= 20 && !charging
  readonly property string icon: IconUtils.getBattery(percentage, charging)
}
