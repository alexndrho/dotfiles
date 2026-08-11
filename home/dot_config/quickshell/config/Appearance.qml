pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import QtCore

Singleton {
  id: root

  property string wallpaper: Quickshell.shellPath("wallpapers/blue_sky.jpg")

  signal backgroundClicked()

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
      "--source-color-index", "0"
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
