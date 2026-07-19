import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.config
import qs.components
import qs.services

ColumnLayout {
  id: contentColumn
  spacing: Theme.spacingMd

  property int iconPreferredWidth: Theme.spacingMd

  RowLayout {
    spacing: Theme.spacingXs

    StyledText {
      text: Battery.icon
      font.pixelSize: Theme.fontSizeLg
      color: Battery.critical ? Theme.yellow : Theme.fg0
    }

    StyledText {
      text: Battery.percent + "%"
      color: Battery.critical ? Theme.yellow : Theme.fg0
    }
  }

  RowLayout {
    spacing: Theme.spacingXs

    StyledText {
      Layout.preferredWidth: content.iconPreferredWidth
      text: Brightness.icon
      font.pixelSize: Theme.fontSizeLg
    }

    StyledSlider {
      Layout.fillWidth: true
      Layout.preferredHeight: implicitHandleHeight + Theme.spacingSm * 2
      from: Brightness.stepSize
      to: 100
      stepSize: Brightness.stepSize
      value: Brightness.level
      onMoved: Brightness.set(value)
    }
  }

  RowLayout {
    spacing: Theme.spacingXs
    StyledText {
      Layout.preferredWidth: content.iconPreferredWidth
      text: Audio.icon
      font.pixelSize: Theme.fontSizeLg
      color: !Audio.muted ? Theme.fg0 : Theme.fg3

      MouseArea {
        anchors {
          fill: parent
        }
        cursorShape: Qt.PointingHandCursor
        onClicked: Audio.sink.audio.muted = !Audio.sink.audio.muted
      }
    }

    StyledSlider {
      Layout.fillWidth: true
      Layout.preferredHeight: implicitHandleHeight + Theme.spacingSm * 2
      from: Audio.stepSize
      to: 100
      stepSize: Audio.stepSize
      value: Audio.volume
      onMoved: Audio.set(value)
    }
  }

  GridLayout {
    Layout.fillWidth: true
    columns: 2
    columnSpacing: Theme.spacingMd
    rowSpacing: Theme.spacingMd
    uniformCellWidths: true

    Repeater {
      model: [
      {
        icon: "󰤨",
        label: "Wifi"
      },
      {
        icon: "",
        label: "Bluetooth"
      }
      ]

      delegate: StyledButton {
        required property var modelData
        Layout.fillWidth: true
        icon: modelData.icon
        label: modelData.label
      }
    }
  }
}
