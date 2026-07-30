import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

PanelWindow {
  id: root

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }

  exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

  property bool opened: false

  visible: opened || content.opacity > 0
  color: "transparent"

  Item {
    id: content

    anchors.fill: parent
    opacity: root.opened ? 1 : 0

    Rectangle {
      anchors.fill: parent
      color: Qt.rgba(Theme.colors.background.r, Theme.colors.background.g, Theme.colors.background.b, 0.5)
    }

    RowLayout {
      anchors.centerIn: parent
      spacing: Theme.spacingMd

      Repeater {
        model: [
        {
          icon: "",
          label: "Shutdown",
          command: ["systemctl", "poweroff"]
        },
        {
          icon: "",
          label: "Reboot",
          command: ["systemctl", "reboot"]
        },
        {
          icon: "󰤄",
          label: "Suspend",
          command: ["systemctl", "suspend"]
        },
        {
          icon: "",
          label: "Lock",
          command: ["swaylock"]
        },
        {
          icon: "",
          label: "Logout",
          command: ["niri", "msg", "action", "quit", "--skip-confirmation"]
        }
        ]

        delegate: Rectangle {
          id: button
          required property var modelData
          property int size: Theme.fontSizeMd * 10

          readonly property bool hovered: hoverHandler.hovered
          readonly property color foregroundColor: hovered ? Theme.colors.on_primary : Theme.colors.on_surface
          readonly property color backgroundColor: hovered ? Theme.colors.primary : Theme.colors.surface

          implicitWidth: size
          implicitHeight: size

          color: backgroundColor
          radius: Theme.radiusMd

          ColumnLayout {
            id: buttonContent

            anchors.centerIn: parent

            StyledText {
              font {
                family: Theme.monoFontFamily
                pixelSize: Theme.fontSizeMd * 4
              }

              Layout.alignment: Qt.AlignCenter
              text: modelData.icon
              color: button.foregroundColor

              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDurationMd
                  easing.type: Easing.OutCubic
                }
              }
            }

            StyledText {
              Layout.alignment: Qt.AlignCenter
              text: modelData.label
              color: button.foregroundColor

              Behavior on color {
                ColorAnimation {
                  duration: Theme.animationDurationMd
                  easing.type: Easing.OutCubic
                }
              }
            }
          }

          Process {
            id: actionProcess
          }

          HoverHandler {
            id: hoverHandler
          }

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor

            onClicked: {
              root.opened = false
              actionProcess.command = button.modelData.command
              actionProcess.running = true
            }
          }

          Behavior on color {
            ColorAnimation {
              duration: Theme.animationDurationMd
              easing.type: Easing.OutCubic
            }
          }
        }
      }
    }

    Behavior on opacity {
      NumberAnimation {
        duration: Theme.animationDurationMd
        easing.type: Easing.OutCubic
      }
    }
  }

  Shortcut {
    sequence: "Escape"
    enabled: root.opened
    onActivated: root.opened = false
  }

  IpcHandler {
    target: "powermenu"

    function toggle(): void {
      root.opened = !root.opened
    }
  }
}
