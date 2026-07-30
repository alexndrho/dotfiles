import Quickshell
import QtQuick
import qs.config
import qs.components

StyledText {
  text: ""
  color: Theme.colors.error

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      Quickshell.execDetached(["qs", "ipc", "call", "powermenu", "toggle"])
    }
  }
}
