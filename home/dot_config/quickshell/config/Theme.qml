pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  readonly property string fontFamily: "Rubik"
  readonly property string monoFontFamily: "CaskaydiaCove Nerd Font Propo"
  readonly property string iconFontFamily: "CaskaydiaCove Nerd Font Propo"
  property alias colors: colorJsonAdapter.md3

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

  // colors
  FileView {
    path: Quickshell.env("HOME") + "/.local/state/quickshell/generated/colors.json"
    watchChanges: true
    onFileChanged: reload()

    JsonAdapter {
      id: colorJsonAdapter

      readonly property Md3 md3: Md3 {}
    }
  }

  // Defaults below fallback to Gruvbox Material Dark Medium
  component Md3: JsonObject {
    property color background: "#282828"
    property color error: "#ea6962"
    property color error_container: "#4c3432"
    property color inverse_on_surface: "#282828"
    property color inverse_primary: "#3b4439"
    property color inverse_surface: "#d4be98"
    property color on_background: "#d4be98"
    property color on_error: "#282828"
    property color on_error_container: "#d4be98"
    property color on_primary: "#32302f"
    property color on_primary_container: "#d4be98"
    property color on_primary_fixed: "#282828"
    property color on_primary_fixed_variant: "#32302f"
    property color on_secondary: "#32302f"
    property color on_secondary_container: "#d4be98"
    property color on_secondary_fixed: "#282828"
    property color on_secondary_fixed_variant: "#32302f"
    property color on_surface: "#d4be98"
    property color on_surface_variant: "#a89984"
    property color on_tertiary: "#32302f"
    property color on_tertiary_container: "#d4be98"
    property color on_tertiary_fixed: "#282828"
    property color on_tertiary_fixed_variant: "#32302f"
    property color outline: "#928374"
    property color outline_variant: "#5a524c"
    property color primary: "#a9b665"
    property color primary_container: "#3b4439"
    property color primary_fixed: "#a9b665"
    property color primary_fixed_dim: "#a9b665"
    property color scrim: "#000000"
    property color secondary: "#d8a657"
    property color secondary_container: "#4f422e"
    property color secondary_fixed: "#d8a657"
    property color secondary_fixed_dim: "#d8a657"
    property color shadow: "#000000"
    property color source_color: "#a9b665"
    property color surface: "#282828"
    property color surface_bright: "#45403d"
    property color surface_container: "#32302f"
    property color surface_container_high: "#3a3735"
    property color surface_container_highest: "#45403d"
    property color surface_container_low: "#282828"
    property color surface_container_lowest: "#1b1b1b"
    property color surface_dim: "#1b1b1b"
    property color surface_tint: "#a9b665"
    property color surface_variant: "#45403d"
    property color tertiary: "#7daea3"
    property color tertiary_container: "#374141"
    property color tertiary_fixed: "#7daea3"
    property color tertiary_fixed_dim: "#7daea3"
  }
}
