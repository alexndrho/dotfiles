import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import qs

ColumnLayout {
  spacing: Theme.spacingSm

  Repeater {
    model: ScriptModel {
      values: [...SystemTray.items.values].reverse()
    }

    delegate: IconImage {
      required property var modelData

      Layout.alignment: Qt.AlignHCenter

      source: modelData.icon || Quickshell.iconPath("application-x-executable")
      implicitSize: Theme.fontSizeLg
    }
  }
}
