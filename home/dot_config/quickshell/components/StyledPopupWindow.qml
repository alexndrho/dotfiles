import Quickshell
import QtQuick
import qs.config

PopupWindow {
  id: root

  default property alias data: surface.data
  property alias child: surface.child
  property alias surfaceTransformOrigin: surface.transformOrigin

  property bool opened: false

  visible: opened || surface.opacity > 0
  implicitWidth: surface.implicitWidth
  implicitHeight: surface.implicitHeight
  color: "transparent"

  onVisibleChanged: {
    if (!visible)
    opened = false
  }

  Wrapper {
    id: surface

    opacity: root.opened ? 1 : 0
    scale: root.opened ? 1 : Theme.popoutClosedScale

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
