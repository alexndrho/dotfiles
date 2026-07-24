import Quickshell
import QtQuick.Controls

import qs.config

TextField {
  placeholderTextColor: Theme.bg3

  property color activeBorderColor: Theme.green
  property color inactiveBorderColor: Theme.bg3

  background: Rectangle {
    color: Theme.bg2
    radius: Theme.radiusSm

    border.width: root.activeFocus ? 2 : 1
    border.color: root.activeFocus
    ? root.activeBorderColor
    : root.inactiveBorderColor

    Behavior on border.color {
      ColorAnimation { duration: 150 }
    }
  }
}
