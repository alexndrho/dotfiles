import Quickshell
import Quickshell.WindowManager
import QtQuick
import QtQuick.Layouts
import qs
import qs.components

ColumnLayout {
  id: root

  required property var screen
  property string fontFamily: Theme.monoFontFamily

  spacing: Theme.spacingXs

  Repeater {
    model: ScriptModel {
      values: WindowManager
      .screenProjection(root.screen)
      .windowsets
      .filter(windowset => windowset.shouldDisplay)
      .sort((a, b) => {
          const aPosition = a.coordinates.length > 0 ? a.coordinates[a.coordinates.length - 1] : 0;
          const bPosition = b.coordinates.length > 0 ? b.coordinates[b.coordinates.length - 1] : 0;
          return aPosition - bPosition;
      })
    }

    delegate: Rectangle {
      id: worksplaceButton

      required property var modelData
      required property int index

      readonly property bool active: modelData.active
      readonly property bool hovered: hoverHandler.hovered
      property int padX: Theme.spacingSm
      property int padY: active ? Theme.spacingMd : Theme.spacingXs

      implicitWidth: content.implicitWidth + padX * 2
      implicitHeight: content.implicitHeight + padY * 2
      color: active ? Theme.green : hovered ? Theme.yellow : Theme.bg1
      radius: Theme.radiusMd

      StyledText {
        id: content

        anchors.centerIn: parent
        text: worksplaceButton.index + 1
        color: active || hovered ? Theme.bg1 : Theme.fg0
        font.family: root.fontFamily

        Behavior on color {
          ColorAnimation {
            duration: Theme.animationDurationMd
            easing.type: Easing.OutCubic
          }
        }
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: modelData.activate()
      }

      HoverHandler {
        id: hoverHandler
      }

      Behavior on implicitHeight {
        NumberAnimation {
          duration: Theme.animationDurationMd
          easing.type: Easing.OutCubic
        }
      }

      Behavior on color {
        ColorAnimation {
          duration: Theme.animationDurationMd
          easing.type: Easing.OutCubic
        }
      }
    }
  }
}
