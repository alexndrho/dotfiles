import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs
import qs.components
import qs.helpers

ColumnLayout {
  id: root
  readonly property var activeWindow: ToplevelManager.activeToplevel
  readonly property string title: activeWindow?.title || "Desktop"
  readonly property var desktopEntry: activeWindow
  ? DesktopEntries.byId(activeWindow.appId)
  : null

  IconImage {
    Layout.alignment: Qt.AlignHCenter

    source: Quickshell.iconPath(
      root.desktopEntry?.icon ?? "application-x-executable"
    )
    implicitSize: Theme.fontSizeMd * 1.25
  }

  StyledText {
    id: titleLabel

    Layout.alignment: Qt.AlignHCenter
    Layout.preferredWidth: implicitHeight
    Layout.preferredHeight: implicitWidth

    text: StringUtils.truncate(root.title, 30)

    transform: Rotation {
      angle: 90
      origin.x: titleLabel.implicitHeight / 2
      origin.y: titleLabel.implicitHeight / 2
    }
  }
}
