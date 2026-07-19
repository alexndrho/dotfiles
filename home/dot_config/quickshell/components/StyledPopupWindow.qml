import Quickshell
import QtQuick

import qs.config
import qs.components

PopupWindow {
  id: root
  default property alias content: content.content
  property bool opened: false
  property real closedScale: 0.9

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight
  visible: false
  color: "transparent"
  grabFocus: true

  onOpenedChanged: {
    if (opened) {
      visible = true
    } else if (content.opacity <= 0) {
      visible = false
    }
  }

  onVisibleChanged: {
    if (!visible && opened) {
      opened = false
    }
  }

  Container {
    id: content
    opacity: root.opened ? 1 : 0
    scale: root.opened ? 1 : root.closedScale
    anchors {
      fill: parent
      centerIn: parent
    }

    Behavior on opacity {
      NumberAnimation {
        duration: Theme.animationDurationMd
        easing.type: Easing.OutCubic
      }
    }

    Behavior on scale {
      NumberAnimation {
        duration: Theme.animationDurationMd
        easing.type: Easing.OutCubic
      }
    }
  }
}
