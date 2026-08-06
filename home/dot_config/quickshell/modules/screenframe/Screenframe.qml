import Quickshell
import QtQuick
import qs.config
import qs.components

PanelWindow {
  id: root

  anchors { top: true; bottom: true; left: true; right: true }

  property int pad: Theme.spacingMd
  property color backgroundColor: Theme.colors.surface

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  mask: Region {
    Region { item: left }
    Region { item: top }
    Region { item: right }
    Region { item: bottom }
  }

  Bar {
    id: left
    screen: root.screen
    padY: root.pad
    color: root.backgroundColor
  }
  Rectangle {
    id: top
    anchors { top: parent.top; left: parent.left; right: parent.right }
    implicitHeight: root.pad
    color: root.backgroundColor
  }
  Rectangle {
    id: right
    anchors { top: parent.top; bottom: parent.bottom; right: parent.right }
    implicitWidth: root.pad
    color: root.backgroundColor
  }
  Rectangle {
    id: bottom
    anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
    implicitHeight: root.pad
    color: root.backgroundColor
  }

  // Top left
  Corner {
    x: left.width
    y: top.height
    color: root.backgroundColor
  }

  // Top right
  Corner {
    x: root.width - right.width - width
    y: top.height
    rotation: 90
    color: root.backgroundColor
  }

  // Bottom left
  Corner {
    x: left.width
    y: root.height - bottom.height - height
    rotation: -90
    color: root.backgroundColor
  }

  // Bottom right
  Corner {
    x: root.width - right.width - width
    y: root.height - bottom.height - height
    rotation: 180
    color: root.backgroundColor
  }

  // Edge reservation
  Scope {
    PanelWindow {
      anchors.left: true
      screen: root.screen
      implicitWidth: left.implicitWidth
      implicitHeight: 0
      color: "transparent"
    }

    PanelWindow {
      anchors.top: true
      screen: root.screen
      implicitWidth: 0
      implicitHeight: top.implicitHeight
      color: "transparent"
    }

    PanelWindow {
      anchors.right: true
      screen: root.screen
      implicitWidth: right.implicitWidth
      implicitHeight: 0
      color: "transparent"
    }

    PanelWindow {
      anchors.bottom: true
      screen: root.screen
      implicitWidth: 0
      implicitHeight: bottom.implicitHeight
      color: "transparent"
    }
  }
}
