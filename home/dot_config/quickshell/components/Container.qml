import Quickshell
import QtQuick

import qs.config

Rectangle {
  default property alias content: content.data
  property alias overlayContent: overlayContent.data
  property int padX: Theme.spacingMd
  property int padY: Theme.spacingMd

  implicitWidth: content.implicitWidth + padX * 2
  implicitHeight: content.implicitHeight + padY * 2
  color: Theme.bg0
  radius: Theme.radiusLg

  Item {
    id: content
    anchors.centerIn: parent
    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height
  }

  Item {
    id: overlayContent
    anchors.fill: parent
  }
}
