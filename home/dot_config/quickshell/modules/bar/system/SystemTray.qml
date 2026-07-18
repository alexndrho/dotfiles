import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components
import qs.modules.bar
import qs.services

Pill {
  id: systemTray
  signal clicked(MouseEvent mouse)

  RowLayout {
    spacing: Theme.spacingMd

    StyledText {
      text: Audio.icon
      font.pixelSize: Theme.fontSizeLg
      color: !Audio.muted ? Theme.fg0 : Theme.fg3
    }

    StyledText {
      text: Network.icon
      font.pixelSize: Theme.fontSizeLg
      color: Network.connected ? Theme.fg0 : Theme.fg3
    }

    StyledText {
      text: Battery.icon
      font.pixelSize: Theme.fontSizeLg
      color: Battery.critical ? Theme.yellow : Theme.fg0
    }
  }

  overlayContent: [
  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: mouse => systemTray.clicked(mouse)
  }
  ]
}
