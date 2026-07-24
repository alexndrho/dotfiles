import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

WrapperMouseArea {
  id: root
  property string icon
  required property string label

  property int padX: Theme.spacingMd
  property int padY: Theme.spacingSm
  property color backgroundColor: Theme.green
  property color foregroundColor: Theme.bg0

  property alias radius: content.radius

  opacity: root.enabled ? 1 : 0.6
  hoverEnabled: root.enabled
  cursorShape: root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

  Container {
    id: content
    padX: root.padX
    padY: root.padY
    color: root.backgroundColor

    RowLayout {
      spacing: Theme.spacingXs

      StyledText {
        text: root.icon
        color: root.foregroundColor
        visible: root.icon
      }

      StyledText {
        text: root.label
        color: root.foregroundColor
      }
    }
  }
}
