import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

Wrapper {
  id: root

  signal clicked()

  property string icon
  property string text
  property int pixelSize: Theme.fontSizeMd
  property color backgroundColor: Theme.colors.primary
  property color foregroundColor: Theme.colors.on_primary

  padX: Theme.spacingMd
  padY: Theme.spacingSm
  color: backgroundColor

  RowLayout {
    id: content
    spacing: Theme.spacingXs

    StyledText {
      text: root.icon
      color: root.foregroundColor
      font {
        family: Theme.iconFontFamily
        pixelSize: root.pixelSize
      }
      visible: !!root.icon
    }

    StyledText {
      text: root.text
      color: root.foregroundColor
      font {
        pixelSize: root.pixelSize
      }
      visible: !!root.text
    }
  }

  HoverHandler {
    cursorShape: Qt.PointingHandCursor
  }

  TapHandler {
    onTapped: clicked()
  }
}
