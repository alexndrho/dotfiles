pragma Singleton
import Quickshell
import QtQuick

Singleton {
  readonly property string fontFamily: "Rubik"
  readonly property string monoFontFamily: "CaskaydiaCove Nerd Font Propo"
  readonly property string iconFontFamily: "CaskaydiaCove Nerd Font Propo"

  //colors
  readonly property color bg0: "#282828"
  readonly property color bg1: "#32302f"
  readonly property color bg2: "#3c3836"
  readonly property color bg3: "#45403d"

  readonly property color fg0: "#d4be98"
  readonly property color fg1: "#ddc7a1"
  readonly property color fg2: "#c7b89d"
  readonly property color fg3: "#a89984"

  readonly property color red: "#ea6962"
  readonly property color orange: "#e78a4e"
  readonly property color yellow: "#d8a657"
  readonly property color green: "#a9b665"
  readonly property color aqua: "#89b482"
  readonly property color blue: "#7daea3"
  readonly property color purple: "#d3869b"

  // spacing
  readonly property int spacingXs: 4
  readonly property int spacingSm: 8
  readonly property int spacingMd: 12
  readonly property int spacingLg: 16
  readonly property int spacingXl: 24

  // font sizes
  readonly property int fontSizeXs: 10
  readonly property int fontSizeSm: 12
  readonly property int fontSizeMd: 14
  readonly property int fontSizeLg: 16
  readonly property int fontSizeXl: 20

  // radius
  readonly property int radiusSm: 8
  readonly property int radiusMd: 10
  readonly property int radiusLg: 12

  // animation
  readonly property int animationDurationSm: 120
  readonly property int animationDurationMd: 200
  readonly property int animationDurationLg: 320
}
