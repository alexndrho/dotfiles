import QtQuick
import qs.config

Rectangle {
  default property alias data: content.data
  property int padX: Theme.spacingMd
  property int padY: Theme.spacingMd

  implicitWidth: content.implicitWidth + padX * 2
  implicitHeight: content.implicitHeight + padY * 2
  color: Theme.colors.surface
  radius: Theme.radiusMd

  Item {
    id: content

    anchors.centerIn: parent
    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height
  }
}
