import Quickshell
import QtQuick
import qs.config

Wrapper {
  id: root

  property bool opened: false

  visible: opened || opacity > 0

  opacity: root.opened ? 1 : 0
  scale: root.opened ? 1 : Theme.popoutClosedScale

  width: implicitWidth
  height: implicitHeight

  Behavior on width {
    NumberAnimation {
      duration: Theme.animationDurationMd
      easing.type: Easing.OutCubic
    }
  }

  Behavior on height {
    NumberAnimation {
      duration: Theme.animationDurationMd
      easing.type: Easing.OutCubic
    }
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
