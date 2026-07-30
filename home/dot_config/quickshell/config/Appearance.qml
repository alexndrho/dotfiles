pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  property url wallpaper: Quickshell.shellPath("wallpapers/blue_sky.jpg")

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
