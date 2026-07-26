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

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusionMode: ExclusionMode.Ignore

    anchors {
      top: true; bottom: true; left: true; right: true
    }

    color: "transparent"

    Image {
      anchors.fill: parent
      source: root.wallpaper
      fillMode: Image.PreserveAspectCrop
    }
  }
}
