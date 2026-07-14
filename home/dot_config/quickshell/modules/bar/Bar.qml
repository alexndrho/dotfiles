import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.modules.bar.system

PanelWindow {
  id: bar
  anchors {
    top: true
    left: true
    right: true
  }

  property int padX: Theme.spacingMd
  property int padY: Theme.spacingSm

  implicitHeight: Math.max(
    leftContent.implicitHeight,
    centerContent.implicitHeight,
    rightContent.implicitHeight
  ) + padY * 2

  color: 'transparent'

  Item {
    anchors {
      fill: parent
      leftMargin: bar.padX
      rightMargin: bar.padX
    }

    // Left
    RowLayout {
      id: leftContent

      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
      }
      spacing: Theme.spacingLg

      Workspaces {
        screen: bar.screen
      }
    }

    // Center
    RowLayout {
      id: centerContent

      anchors {
        centerIn: parent
        verticalCenter: parent.verticalCenter
      }
      spacing: Theme.spacingLg

      Clock {}
    }

    // Right
    RowLayout {
      id: rightContent

      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
      }
      spacing: Theme.spacingLg

      SystemTray {}
    }
  }

}
