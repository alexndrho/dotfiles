import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import qs.config

ColumnLayout {
  spacing: Theme.spacingSm

  Repeater {
    model: ScriptModel {
      values: [...SystemTray.items.values].reverse()
    }

    delegate: IconImage {
      required property var modelData
      readonly property var entry: DesktopEntries.heuristicLookup(modelData.id)

      Layout.alignment: Qt.AlignHCenter

      source: (entry?.icon && Quickshell.iconPath(entry.icon, true))
        || modelData.icon
        || Quickshell.iconPath("application-x-executable")
      implicitSize: Theme.fontSizeLg
    }
  }
}
