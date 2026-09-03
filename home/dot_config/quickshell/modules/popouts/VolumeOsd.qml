import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.components

RowLayout {
  id: root

  spacing: Theme.spacingMd
  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight

  RowLayout {
    id: content

    Layout.alignment: Qt.AlignHCenter
    spacing: Theme.spacingMd

    StyledText {
      Layout.preferredWidth: Theme.spacingMd
      horizontalAlignment: Text.AlignHCenter
      text: Audio.icon
      font {
        family: Theme.iconFontFamily
        pixelSize: Theme.fontSizeXl
      }
    }

    ValueBar {
      Layout.alignment: Qt.AlignHCenter
      value: Audio.volume
    }
  }
}
