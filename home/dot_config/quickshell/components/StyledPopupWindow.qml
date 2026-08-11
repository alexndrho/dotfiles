import Quickshell
import QtQuick
import qs.config

PopupWindow {
  id: root

  default property alias data: content.data
  property alias content: content

  property bool opened: false
  property real closedScale: 0.95

  visible: opened || content.opacity > 0
  grabFocus: true

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight
  color: "transparent"

  onVisibleChanged: {
    if (!visible)
    opened = false
  }

  Wrapper {
    id: content

    opacity: root.opened ? 1 : 0
    scale: root.opened ? 1 : root.closedScale

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
