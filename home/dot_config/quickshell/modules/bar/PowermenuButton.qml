import Quickshell
import QtQuick
import qs
import qs.components

StyledText {
  text: ""
  color: Theme.red

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      Quickshell.execDetached(["qs", "ipc", "call", "powermenu", "toggle"])
    }
  }
}
