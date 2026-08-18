import Quickshell.Widgets
import qs.config

WrapperRectangle {
  property int padX: Theme.spacingMd
  property int padY: Theme.spacingMd

  leftMargin: padX
  rightMargin: padX
  topMargin: padY
  bottomMargin: padY
  color: Theme.colors.surface
  radius: Theme.radiusMd

  // Item {
  //   id: content
  //
  //   anchors.centerIn: parent
  //   implicitWidth: childrenRect.width
  //   implicitHeight: childrenRect.height
  // }
}
