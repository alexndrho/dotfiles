import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

Rectangle {
  id: root
  required property string icon
  required property string label
  property int padX: Theme.spacingMd
  property int padY: Theme.spacingSm
  property color backgroundColor: Theme.green
  property color foregroundColor: Theme.bg0

  color: backgroundColor
  radius: Theme.radiusMd

  implicitWidth: content.implicitWidth + padX * 2
  implicitHeight: content.implicitHeight + padY * 2

  RowLayout {
    id: content
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
