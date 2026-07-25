pragma Singleton
import Quickshell
import Quickshell.Bluetooth

Singleton {
  readonly property var adapter: Bluetooth.defaultAdapter
  readonly property bool enabled: adapter.enabled
  readonly property var devices: Bluetooth.devices

  function setEnabled(enabled: bool): void {
    adapter.enabled = enabled
  }
}
