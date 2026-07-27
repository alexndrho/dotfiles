import Quickshell
import Quickshell.Wayland
import QtQuick

Variants {
  id: root
  model: Quickshell.screens

  property url wallpaper: Quickshell.shellPath("wallpapers/blue_sky.jpg")

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
