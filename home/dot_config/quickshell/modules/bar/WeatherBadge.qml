import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components
import qs.services

ColumnLayout {
  spacing: Theme.spacingXs

  StyledText {
    Layout.alignment: Qt.AlignHCenter
    text: Weather.icon
    font.family: Theme.iconFontFamily
  }

  StyledText {
    Layout.alignment: Qt.AlignHCenter
    text: Weather.tempC
    font.family: Theme.monoFontFamily
  }
}
