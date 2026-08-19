pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import QtCore

Singleton {
  id: root

  property string wallpaper: Quickshell.env("HOME") + "/Pictures/wallpapers/blue_sky.jpg"

  Settings {
    category: "appearance"
    location: Qt.resolvedUrl(Quickshell.shellPath("settings.ini"))
    property alias wallpaper: root.wallpaper
  }

  function generateColors(): void {
    matugen.exec([
      "matugen",
      "image",
      root.wallpaper,
      "--mode", "dark",
      ])
  }

  onWallpaperChanged: {
    generateColors()
  }

  Component.onCompleted: {
    generateColors()
  }

  Process {
    id: matugen
  }
}
