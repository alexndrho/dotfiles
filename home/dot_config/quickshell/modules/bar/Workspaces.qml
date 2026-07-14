import Quickshell
import Quickshell.WindowManager
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.config
import qs.components

Pill {
  id: workspaces
  required property var screen

  RowLayout {
    spacing: Theme.spacingXs

    Repeater {
      model: ScriptModel {
        values: WindowManager
        .screenProjection(workspaces.screen)
        .windowsets
        .filter(windowset => windowset.shouldDisplay)
        .sort((a, b) => {
            const aPosition = a.coordinates.length > 0 ? a.coordinates[a.coordinates.length - 1] : 0;
            const bPosition = b.coordinates.length > 0 ? b.coordinates[b.coordinates.length - 1] : 0;
            return aPosition - bPosition;
        })
      }

      delegate: Button {
        property int padX: modelData.active ? 16 : 10
        property int padY: 1

        implicitWidth: label.implicitWidth + padX * 2
        implicitHeight: label.implicitHeight + padY * 2
        hoverEnabled: true

        onClicked: modelData.activate()

        Behavior on implicitWidth {
          NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
          }
        }

        HoverHandler {
          cursorShape: Qt.PointingHandCursor
        }

        background: Rectangle {
          color: modelData.active ? Theme.green : parent.hovered ? Theme.yellow : Theme.bg1
          radius: Theme.radiusSm

          Behavior on color {
            ColorAnimation {
              duration: 200
              easing.type: Easing.OutCubic
            }
          }
        }

        contentItem: StyledText {
          id: label
          text: index + 1
          color: modelData.active || parent.hovered ? Theme.bg1 : Theme.fg1
          horizontalAlignment: Text.AlignHCenter
          verticalAlignment: Text.AlignVCenter

          Behavior on color {
            ColorAnimation {
              duration: 200
              easing.type: Easing.OutCubic
            }
          }
        }
      }
    }
  }
}
