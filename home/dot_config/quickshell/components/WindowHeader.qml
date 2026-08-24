import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

RowLayout {
  id: root

  property color foregroundColor: Theme.colors.on_surface
  property string iconText
  required property string text

  spacing: Theme.spacingSm

  StyledText {
    text: root.iconText
    color: root.foregroundColor
    font.family: Theme.iconFontFamily
  }

  StyledText {
    text: root.text
    color: root.foregroundColor
  }
}
