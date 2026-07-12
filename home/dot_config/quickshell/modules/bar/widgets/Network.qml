import Quickshell
import Quickshell.Networking
import QtQuick

import qs.config
import qs.components

Item {
  id: network
  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight

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
    if (signalStrength >= 75) return "󰤨"
    if (signalStrength >= 50) return "󰤥"
    if (signalStrength >= 25) return "󰤢"
    return "󰤟"
  }

  StyledText {
    id: label
    text: network.icon
    font.pixelSize: Theme.fontSizeLg
    color: network.connected ? Theme.fg0 : Theme.fg3
  }
}
