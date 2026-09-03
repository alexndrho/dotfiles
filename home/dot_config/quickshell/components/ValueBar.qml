import QtQuick
import qs.config

Item {
  id: root

  property real value: 0
  property real minimum: 0
  property real maximum: 100
  property int barWidth: Theme.spacingMd * 18
  property int barHeight: Theme.spacingSm
  property color trackColor: Theme.colors.surface_container_highest
  property color fillColor: Theme.colors.on_surface

  readonly property real range: Math.max(1, maximum - minimum)
  readonly property real progress: Math.max(0, Math.min(1, (value - minimum) / range))

  implicitWidth: barWidth
  implicitHeight: barHeight

  Rectangle {
    id: track

    anchors.fill: parent
    color: root.trackColor
    radius: height / 2
    clip: true

    Rectangle {
      anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
      }

      width: Math.round(track.width * root.progress)
      color: root.fillColor
      radius: track.radius

      Behavior on width {
        NumberAnimation {
          duration: Theme.animationDurationSm
          easing.type: Easing.OutCubic
        }
      }
    }
  }
}
