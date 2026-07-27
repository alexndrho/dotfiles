import Quickshell
import QtQuick
import QtQuick.Layouts
import qs
import qs.components

Item {
  id: root

  readonly property var timeParts: Qt.formatDateTime(clock.date, "hh mm AP")

  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight

  ColumnLayout {
    id: content
    spacing: 0

    Repeater {
      model: root.timeParts.split(" ")

      delegate: StyledText {
        Layout.alignment: Qt.AlignHCenter
        required property var modelData

        text: modelData
        font {
          family: Theme.monoFontFamily
          pixelSize: Theme.fontSizeMd
        }
      }
    }
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
