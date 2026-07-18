import Quickshell
import QtQuick

import qs.components

PopupWindow {
  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight
  color: "transparent"
  grabFocus: true

  default property alias content: content.content

  Container {
    id: content
    anchors {
      fill: parent
      centerIn: parent
    }
  }
}
