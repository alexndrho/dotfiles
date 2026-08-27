import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

PanelWindow {
  id: root

  anchors { top: true; bottom: true; left: true }

  property int padX: Theme.spacingSm
  property int padY: Theme.spacingMd
  property int spacing: Theme.spacingMd

  implicitWidth: Math.max(
    leftContent.implicitWidth,
    centerContent.implicitWidth,
    rightContent.implicitWidth
  ) + padX * 2
  color: Theme.colors.surface

  Item {
    anchors {
      fill: parent
      topMargin: root.padY
      bottomMargin: root.padY
      leftMargin: root.padX
      rightMargin: root.padX
    }

    // Left
    ColumnLayout {
      id: leftContent
      anchors {
        top: parent.top
        horizontalCenter: parent.horizontalCenter
      }

      spacing: root.spacing

      Workspaces {
        Layout.alignment: Qt.AlignHCenter
        screen: root.screen
      }
      WeatherBadge {
        Layout.alignment: Qt.AlignHCenter
      }
    }

    // Center
    ColumnLayout {
      id: centerContent
      anchors {
        centerIn: parent
      }

      spacing: root.spacing

      ActiveWindow {
        Layout.alignment: Qt.AlignHCenter
      }
    }

    // Right
    ColumnLayout {
      id: rightContent
      anchors {
        bottom: parent.bottom
        horizontalCenter: parent.horizontalCenter
      }

      spacing: root.spacing

      Tray {
        Layout.alignment: Qt.AlignHCenter
      }
      Clock {
        Layout.alignment: Qt.AlignHCenter
      }
      Indicators {
        Layout.alignment: Qt.AlignHCenter
      }
      PowermenuButton {
        Layout.alignment: Qt.AlignHCenter
      }
    }
  }

}
