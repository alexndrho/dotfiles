import QtQuick
import QtQuick.Controls

import qs.config

TextField {
  id: root

  property color backgroundColor: Theme.bg2
  property color disabledBackgroundColor: Theme.bg1
  property color borderColor: activeFocus ? Theme.green : Theme.fg3

  leftPadding: Theme.spacingMd
  rightPadding: Theme.spacingMd
  topPadding: Theme.spacingMd
  bottomPadding: Theme.spacingMd

  selectByMouse: true
  activeFocusOnTab: true
  font.family: Theme.fontFamily
  font.pixelSize: Theme.fontSizeMd
  color: Theme.fg0
  placeholderTextColor: Theme.fg3
  selectionColor: Theme.green
  selectedTextColor: Theme.bg0

  background: Rectangle {
    color: root.enabled ? root.backgroundColor : root.disabledBackgroundColor
    radius: Theme.radiusMd
    border {
      width: 1
      color: root.borderColor
    }

    Behavior on border.color {
      ColorAnimation {
        duration: Theme.animationDurationMd
        easing.type: Easing.OutCubic
      }
    }
  }
}
