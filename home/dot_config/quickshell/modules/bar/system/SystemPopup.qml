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
        default:
        return null
      }
    }
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
      onBackClicked: root.currentView = SystemPopup.View.Main
    }
  }

  onVisibleChanged: {
    if (!visible) {
      currentView = SystemPopup.View.Main
    }
  }
}
