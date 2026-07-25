import Quickshell
import QtQuick

import qs.components

StyledPopupWindow {
  id: root

  enum View {
    Main,
    Wifi,
    Bluetooth
  }

  property int currentView: SystemPopup.View.Main

  Loader {
    sourceComponent: {
      switch (root.currentView) {
        case SystemPopup.View.Main:
        return mainPage
        case SystemPopup.View.Wifi:
        return wifiPage
        case SystemPopup.View.Bluetooth:
        return bluetoothPage
        default:
        return null
      }
    }
  }

  function goHome() {
    root.currentView = SystemPopup.View.Main
  }

  Component {
    id: mainPage

    SystemMainMenuContent {
      onWifiRequested: root.currentView = SystemPopup.View.Wifi
      onBluetoothRequested: root.currentView = SystemPopup.View.Bluetooth
    }
  }

  Component {
    id: wifiPage

    SystemWifiContent {
      onBackClicked: goHome()
    }
  }

  Component {
    id: bluetoothPage

    SystemBluetoothContent {
      onBackClicked: goHome()
    }
  }

  onVisibleChanged: {
    if (!visible) {
      currentView = SystemPopup.View.Main
    }
  }
}
