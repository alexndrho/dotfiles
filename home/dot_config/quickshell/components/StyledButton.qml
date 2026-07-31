import QtQuick
import qs.config

Rectangle {
  id: root

  property int padX: Theme.spacingMd
  property int padY: Theme.spacingMd
  property alias content: content

  implicitWidth: content.implicitWidth + padX * 2
  implicitHeight: content.implicitHeight + padY * 2
  color: Theme.colors.primary
  radius: Theme.radiusMd

  StyledText {
    id: content

    anchors.centerIn: parent
    color: Theme.colors.on_primary
  }

  HoverHandler {
    cursorShape: Qt.PointingHandCursor
  }
}
