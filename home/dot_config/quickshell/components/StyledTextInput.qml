import QtQuick
import QtQuick.Controls
import qs.config

Rectangle {
  id: root

  property int padX: Theme.spacingMd
  property int padY: Theme.spacingMd
  property string placeholderText: ""
  property bool centered: false
  property bool loading: false
  property bool hasError: false
  property alias input: input
  property alias hoverEnabled: hoverHandler.enabled

  implicitWidth: input.implicitWidth + padX * 2
  implicitHeight: Math.ceil(inputMetrics.height) + padY * 2
  color: Theme.colors.surface_container
  radius: Theme.radiusMd

  border {
    width: 1
    color: hasError ? Theme.colors.error : input.activeFocus ? Theme.colors.primary : Theme.colors.outline
  }

  signal accepted(string text)

  TextInput {
    id: input

    anchors {
      fill: parent
      topMargin: root.padY
      bottomMargin: root.padY
      leftMargin: root.padX
      rightMargin: root.padX
    }

    horizontalAlignment: root.centered
    ? TextInput.AlignHCenter
    : TextInput.AlignLeft

    font {
      family: Theme.fontFamily
      pixelSize: Theme.fontSizeMd
    }

    color: Theme.colors.on_surface
    verticalAlignment: TextInput.AlignVCenter
    clip: true
    selectByMouse: true

    onAccepted: {
      if (!root.loading) {
        root.accepted(text)
      }
    }

    FontMetrics {
      id: inputMetrics
      font: input.font
    }
  }

  Text {
    anchors {
      left: input.left
      right: input.right
      verticalCenter: input.verticalCenter
    }

    horizontalAlignment: root.centered
    ? Text.AlignHCenter
    : Text.AlignLeft

    text: root.placeholderText
    font: input.font
    color: Theme.colors.on_surface_variant
    visible: root.placeholderText.length !== 0 && input.text.length === 0
  }

  BusyIndicator {
    id: spinner

    anchors {
      right: parent.right
      rightMargin: root.padX
      verticalCenter: parent.verticalCenter
    }

    width: Math.ceil(inputMetrics.height)
    height: width
    padding: 0

    palette.text: input.color

    running: root.loading
    visible: running
  }

  HoverHandler {
    id: hoverHandler
    cursorShape: Qt.PointingHandCursor
  }

  Behavior on border.color {
    ColorAnimation {
      duration: Theme.animationDurationSm
      easing.type: Easing.InOutCubic
    }
  }
}
