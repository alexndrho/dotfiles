import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

WrapperMouseArea {
  id: root
  required property string icon
  required property string label

  property int padX: Theme.spacingMd
  property int padY: Theme.spacingSm
  property color backgroundColor: Theme.green
  property color foregroundColor: Theme.bg0

  property alias radius: content.radius

  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor

  Container {
    id: content
    padX: root.padX
    padY: root.padY
    color: root.backgroundColor

    RowLayout {
      anchors.centerIn: parent
      spacing: Theme.spacingXs

      StyledText {
        text: root.icon
        color: root.foregroundColor
      }

      StyledText {
        text: root.label
        color: root.foregroundColor
      }
    }
  }
}
