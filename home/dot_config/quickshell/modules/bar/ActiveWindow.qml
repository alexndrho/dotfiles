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

  Item {
    id: iconSlot

    Layout.alignment: Qt.AlignHCenter

    property int iconImplicitSize: Theme.fontSizeLg

    implicitWidth: iconImplicitSize
    implicitHeight: iconImplicitSize

    property string displayedIcon: root.desktopEntry?.icon ?? ""

    StyledText {
      anchors.centerIn: parent
      visible: !iconSlot.displayedIcon
      text: ""
      font.family: Theme.iconFontFamily
    }

    IconImage {
      anchors.centerIn: parent
      implicitSize: iconSlot.iconImplicitSize
      visible: !!iconSlot.displayedIcon
      source: Quickshell.iconPath(iconSlot.displayedIcon)
    }

    Behavior on displayedIcon {
      SequentialAnimation {
        NumberAnimation {
          target: iconSlot
          property: "scale"
          to: 0
          duration: Theme.animationDurationSm
          easing.type: Easing.InCubic
        }

        PropertyAction {}

        NumberAnimation {
          target: iconSlot
          property: "scale"
          to: 1
          duration: Theme.animationDurationSm
          easing.type: Easing.OutCubic
        }
      }
    }
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

    Behavior on text {
      SequentialAnimation {
        NumberAnimation {
          target: titleLabel
          property: "opacity"
          to: 0
          duration: Theme.animationDurationSm
          easing.type: Easing.InCubic
        }

        PropertyAction {}

        NumberAnimation {
          target: titleLabel
          property: "opacity"
          to: 1
          duration: Theme.animationDurationSm
          easing.type: Easing.OutCubic
        }
      }
    }
  }
}
