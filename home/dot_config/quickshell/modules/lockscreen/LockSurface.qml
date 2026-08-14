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

  Item {
    id: content
    anchors.centerIn: parent

    width: Math.min(parent.width - Theme.spacingXl * 2, 350)
    height: Math.min(parent.height - Theme.spacingXl * 2, 800)

    property bool showPassword:
    root.context.currentText.length > 0
    || root.context.unlockInProgress
    || root.context.showFailure

    states: State {
      name: "active"
      when: content.showPassword

      AnchorChanges {
        target: clockSection
        anchors {
          top: parent.top
          verticalCenter: undefined
        }
      }

      PropertyChanges {
        target: passwordPrompt
        opacity: 0
      }

      PropertyChanges {
        target: passwordSection
        opacity: 1
      }
    }

    transitions: Transition {
      AnchorAnimation {
        duration: Theme.animationDurationMd
        easing.type: Easing.InOutQuad
      }

      NumberAnimation {
        properties: "opacity"
        duration: Theme.animationDurationMd
        easing.type: Easing.InOutQuad
      }
    }

    ColumnLayout {
      id: clockSection

      anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
      }

      StyledText {
        Layout.alignment: Qt.AlignHCenter

        text: Qt.formatDateTime(clock.date, "dddd, MMMM d")
        font.pixelSize: Theme.fontSizeXl
      }

      StyledText {
        Layout.alignment: Qt.AlignHCenter

        text: Qt.formatDateTime(clock.date, "hh:mm AP")
        font.pixelSize: Theme.fontSizeXl * 4
      }
    }

    StyledText {
      id: passwordPrompt

      anchors {
        bottom: parent.bottom
        horizontalCenter: parent.horizontalCenter
      }

      text: "Start typing your password to unlock"
      horizontalAlignment: Text.AlignHCenter
      opacity: 1
    }

    ColumnLayout {
      id: passwordSection

      anchors {
        bottom: parent.bottom
        left: parent.left
        right: parent.right
      }

      opacity: 0

      StyledTextInput {
        id: passwordInput

        Layout.fillWidth: true
        Layout.maximumWidth: Theme.spacingMd * 25
        Layout.alignment: Qt.AlignHCenter

        centered: true
        input.echoMode: TextInput.Password
        input.inputMethodHints: Qt.ImhSensitiveData
        input.text: root.context.currentText
        input.onTextEdited: root.context.currentText = input.text
        hoverEnabled: passwordSection.opacity > 0
        loading: root.context.unlockInProgress
        hasError: root.context.showFailure

        onAccepted: root.context.tryUnlock()

        Component.onCompleted: {
          Qt.callLater(() => passwordInput.input.forceActiveFocus())
        }
      }

      StyledText {
        Layout.alignment: Qt.AlignHCenter

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
