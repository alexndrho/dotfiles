import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.config
import qs.services

Rectangle {
  id: root

  property int padX: Theme.spacingSm
  property int padY: Theme.spacingSm
  property string fontFamily: Theme.iconFontFamily

  implicitWidth: content.implicitWidth + padX * 2
  implicitHeight: content.implicitHeight + padY * 2
  color: Theme.colors.surface_container
  radius: Theme.spacingMd

  ColumnLayout {
    id: content

    anchors.centerIn: parent
    spacing: Theme.spacingSm

    StyledText {
      Layout.alignment: Qt.AlignHCenter

      text: Audio.icon

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
          Quickshell.execDetached(["kitty", "-e", "bluetui"])
        }
      }
    }

    StyledText {
      Layout.alignment: Qt.AlignHCenter

      text: Network.icon

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
          Quickshell.execDetached(["kitty", "-e", "nmtui"])
        }
      }
    }

    StyledText {
      Layout.alignment: Qt.AlignHCenter

      text: Battery.icon
      color: Battery.critical ? Theme.colors.error : Theme.colors.on_surface
      font.family: root.fontFamily
    }
  }
}
