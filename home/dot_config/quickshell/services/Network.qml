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

  readonly property bool wiredConnected: Networking.devices.values.some(
    device => device.type === DeviceType.Wired && device.connected
  )
  readonly property bool wifiConnected: Networking.wifiEnabled && connectedWifiNetwork !== null
  readonly property bool connected: wiredConnected || wifiConnected

  readonly property int signalStrength: wifiConnected
  ? Math.round(connectedWifiNetwork.signalStrength * 100)
  : 0

  readonly property string icon: {
    if (wiredConnected) return "";
    if (!connected) return "󰤭";
    return wifiIconForSignal(signalStrength)
  }

  readonly property var wifiDevice: {
    const devices = Networking.devices.values;

    for (let i = 0; i < devices.length; i++) {
      if (devices[i].type === DeviceType.Wifi)
      return devices[i];
    }

    return null;
  }

  readonly property var wifiNetworks: wifiDevice ? wifiDevice.networks : null

  function setWifiEnabled(enabled: bool): void {
    Networking.wifiEnabled = enabled;
  }

  function setScannerEnabled(enabled: bool): void {
    if (wifiDevice)
    wifiDevice.scannerEnabled = enabled;
  }

  function wifiIconForSignal(signalPercent: real): string {
    if (signalPercent >= 75) return "󰤨";
    if (signalPercent >= 50) return "󰤥";
    if (signalPercent >= 25) return "󰤢";
    return "󰤟";
  }
}
