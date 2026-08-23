import Quickshell
import QtQuick
import qs.config

Wrapper {
  id: root

  property bool opened: false
  property int slideEdge: {
    if (!root.parent)
    return 0

    const tolerance = 1
    let edges = 0

    if (Math.abs(root.x) <= tolerance)
    edges |= Qt.LeftEdge
    if (Math.abs(root.y) <= tolerance)
    edges |= Qt.TopEdge
    if (Math.abs(root.x + root.width - root.parent.width) <= tolerance)
    edges |= Qt.RightEdge
    if (Math.abs(root.y + root.height - root.parent.height) <= tolerance)
    edges |= Qt.BottomEdge

    return edges
  }
  property real slideProgress: opened ? 1 : 0

  visible: opened || slideProgress > 0
  width: implicitWidth
  height: implicitHeight

  topLeftRadius: root.slideEdge & (Qt.TopEdge | Qt.LeftEdge)
  ? 0
  : root.radius

  topRightRadius: root.slideEdge & (Qt.TopEdge | Qt.RightEdge)
  ? 0
  : root.radius

  bottomLeftRadius: root.slideEdge & (Qt.BottomEdge | Qt.LeftEdge)
  ? 0
  : root.radius

  bottomRightRadius: root.slideEdge & (Qt.BottomEdge | Qt.RightEdge)
  ? 0
  : root.radius

  transform: Translate {
    x: {
      if (root.slideEdge & Qt.LeftEdge)
      return -(root.width + Theme.spacingMd) * (1 - root.slideProgress)
      if (root.slideEdge & Qt.RightEdge)
      return (root.width + Theme.spacingMd) * (1 - root.slideProgress)
      return 0
    }

    y: {
      if (root.slideEdge & Qt.TopEdge)
      return -(root.height + Theme.spacingMd) * (1 - root.slideProgress)
      if (root.slideEdge & Qt.BottomEdge)
      return (root.height + Theme.spacingMd) * (1 - root.slideProgress)
      return 0
    }
  }

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

  Behavior on slideProgress {
    NumberAnimation {
      duration: Theme.animationDurationMd
      easing.type: Easing.OutCubic
    }
  }
}
