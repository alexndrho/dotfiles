import QtQuick

ListView {
  id: root

  property var entries
  property bool keyboardNavigation: false

  model: entries
  currentIndex: entries.length > 0 ? 0 : -1
  clip: true

  function moveSelection(offset) {
    if (root.count === 0)
    return;

    keyboardNavigation = true

    root.currentIndex = Math.max(
      0,
      Math.min(
        root.count - 1,
        root.currentIndex + offset
      )
    );

    root.positionViewAtIndex(
      root.currentIndex,
      ListView.Contain
    );
  }

  Shortcut {
    sequence: "Down"
    onActivated: root.moveSelection(1)
  }

  Shortcut {
    sequence: "Up"
    onActivated: root.moveSelection(-1)
  }

  Shortcut {
    sequence: "Ctrl+N"
    onActivated: root.moveSelection(1)
  }

  Shortcut {
    sequence: "Ctrl+P"
    onActivated: root.moveSelection(-1)
  }

  component DelegateHoverHandler: HoverHandler {
    required property var view
    required property int index

    onPointChanged: view.keyboardNavigation = false

    onHoveredChanged: {
      if (hovered && !view.keyboardNavigation) {
        view.currentIndex = index
      }
    }
  }
}
