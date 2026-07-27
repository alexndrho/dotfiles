pragma Singleton
import Quickshell
import Quickshell.Networking

Singleton {
  readonly property bool wifiEnabled: Networking.wifiEnabled
  readonly property bool wifiAvailable: Networking.wifiHardwareEnabled

  readonly property var connectedWifiNetwork: {
    const devices = Networking.devices.values;

    for (let i = 0; i < devices.length; i++) {
      if (devices[i].type !== DeviceType.Wifi) continue;

      const networks = devices[i].networks.values;
      for (let j = 0; j < networks.length; j++) {
        if (networks[j].connected) return networks[j];
      }
    }

    return null;
  }

  // Connection
  readonly property bool wiredConnected: Networking.devices.values.some(
    device => device.type === DeviceType.Wired && device.connected
  )
  readonly property bool wifiConnected: Networking.wifiEnabled && connectedWifiNetwork !== null
  readonly property bool connected: wiredConnected || wifiConnected

  readonly property int wifiSignalStrength: wifiConnected
  ? Math.round(connectedWifiNetwork.signalStrength * 100)
  : 0

  readonly property string icon: {
    if (wiredConnected) return "";
    if (!connected) return "󰤭";

    // Wifi
    if (wifiSignalStrength >= 75) return "󰤨";
    if (wifiSignalStrength >= 50) return "󰤥";
    if (wifiSignalStrength >= 25) return "󰤢";
    return "󰤟";
  }
}
