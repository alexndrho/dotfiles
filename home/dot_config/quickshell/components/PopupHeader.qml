import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

RowLayout {
  id: root
  required property string title
  property bool showBackButton: false

  signal backClicked()

  spacing: Theme.spacingSm

  Rectangle {
    id: backButton
    property int padX: 6
    property int padY: 4

    implicitWidth: backButtonContent.implicitWidth + padX * 2
    implicitHeight: backButtonContent.implicitHeight + padY * 2
    color: !backButtonHoverHandler.hovered ? Theme.bg0 : Theme.bg3
    radius: Theme.radiusMd
    visible: root.showBackButton

    StyledText {
      id: backButtonContent
      anchors {
        centerIn: parent
      }
      text: ""
    }

    MouseArea {
      anchors {
        fill: parent
      }
      cursorShape: Qt.PointingHandCursor
      onClicked: root.backClicked()
    }

    HoverHandler {
      id: backButtonHoverHandler
    }
  }

  StyledText {
    text: root.title
  }
}
