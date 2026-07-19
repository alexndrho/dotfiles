import Quickshell
import QtQuick

import qs.components

StyledPopupWindow {
  id: root

  enum View {
    Main,
    Network,
    Bluetooth
  }

  property int currentView: SystemPopup.View.Main

  SystemMainMenuContent { visible: root.currentView === SystemPopup.View.Main }
}
