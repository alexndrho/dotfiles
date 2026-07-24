import Quickshell
import QtQuick

StyledText {
  id: root
  text: ""

  RotationAnimator on rotation {
    from: 0
    to: 360
    duration: 1000
    loops: Animation.Infinite
    running: root.visible
  }
}
