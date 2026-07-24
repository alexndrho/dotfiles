import QtQuick

import qs.config

// [TODO]: Add disabled property
Item {
  id: root
  property bool checked: false
  property color backgroundColor: Theme.bg3
  property color checkedBackgroundColor: Theme.green
  property color handleColor: Theme.fg0
  property color checkedHandleColor: Theme.bg0

  signal toggled(bool checked)

  implicitWidth: Theme.fontSizeXl * 2
  implicitHeight: Theme.fontSizeXl

  Rectangle {
    id: track
    anchors.fill: parent
    radius: height / 2
    color: root.checked ? root.checkedBackgroundColor : root.backgroundColor

    Behavior on color {
      ColorAnimation {
        duration: Theme.animationDurationMd
        easing.type: Easing.OutCubic
      }
    }

    Rectangle {
      id: thumb
      width: parent.height - 4
      height: width
      radius: width / 2
      color: root.checked ? root.checkedHandleColor : root.handleColor
      y: 2
      x: root.checked ? parent.width - width - 2 : 2

      Behavior on x {
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

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      root.checked = !root.checked
      root.toggled(root.checked)
    }
  }
}
