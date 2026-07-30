import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import qs.config

Variants {
  id: root
  model: Quickshell.screens

  property url wallpaper: Appearance.wallpaper

  delegate: PanelWindow {
    required property var modelData
    screen: modelData

    anchors {
      top: true; bottom: true; left: true; right: true
    }

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusionMode: ExclusionMode.Ignore

    color: "transparent"

    Image {
      anchors.fill: parent
      source: root.wallpaper
      fillMode: Image.PreserveAspectCrop
    }
  }
}
