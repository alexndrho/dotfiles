import QtQuick
import QtQuick.Shapes
import qs.config

Shape {
  id: corner
  preferredRendererType: Shape.CurveRenderer

  property real radius: Theme.radiusMd
  property alias color: shapePath.fillColor

  ShapePath {
    id: shapePath
    strokeWidth: 0
    fillColor: Theme.colors.surface

    startX: corner.radius

    PathArc {
      relativeX: -corner.radius
      relativeY: corner.radius
      radiusX: corner.radius
      radiusY: corner.radius
      direction: PathArc.Counterclockwise
    }

    PathLine {
      relativeX: 0
      relativeY: -corner.radius
    }

    PathLine {
      relativeX: corner.radius
      relativeY: 0
    }
  }
}
