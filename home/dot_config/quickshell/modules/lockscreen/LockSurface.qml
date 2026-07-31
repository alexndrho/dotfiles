import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.config
import qs.components

Image {
  id: root
  required property LockContext context

  source: Appearance.wallpaper
  fillMode: Image.PreserveAspectCrop

  ColumnLayout {
    anchors.centerIn: parent
    spacing: Theme.spacingXl

    width: Math.min(parent.width - Theme.spacingXl * 2, 350)
    height: Math.min(parent.height - Theme.spacingXl * 2, 800)

    ColumnLayout {
      Layout.alignment: Qt.AlignHCenter

      StyledText {
        Layout.alignment: Qt.AlignHCenter

        text: Qt.formatDateTime(clock.date, "hh:mm AP")

        font.pixelSize: Theme.fontSizeXl * 4
      }

      StyledText {
        Layout.alignment: Qt.AlignHCenter

        text: Qt.formatDateTime(clock.date, "dddd, MMMM d")

        font.pixelSize: Theme.fontSizeXl
      }
    }

    Item {
      Layout.fillHeight: true
    }

    ColumnLayout {
      Layout.fillWidth: true

      StyledTextInput {
        id: passwordInput

        Layout.fillWidth: true

        placeholderText: "Enter your password"
        input.echoMode: TextInput.Password
        input.inputMethodHints: Qt.ImhSensitiveData
        input.text: root.context.currentText
        input.onTextEdited: root.context.currentText = input.text
        loading: root.context.unlockInProgress
        hasError: root.context.showFailure

        onAccepted: root.context.tryUnlock()

        Component.onCompleted: {
          Qt.callLater(() => passwordInput.input.forceActiveFocus())
        }
      }

      StyledText {
        text: "Incorrect password"
        color: Theme.colors.error
        opacity: root.context.showFailure ? 1 : 0

        Behavior on opacity {
          NumberAnimation {
            duration: Theme.animationDurationSm
            easing.type: Easing.InOutCubic
          }
        }
      }
    }
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
