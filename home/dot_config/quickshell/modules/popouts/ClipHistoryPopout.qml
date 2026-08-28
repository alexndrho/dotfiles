import QtQuick
import QtQuick.Layouts
import qs.config
import qs.services
import qs.components

ColumnLayout {
  spacing: Theme.spacingMd

  readonly property bool isEmpty: ClipManager.history.length <= 0

  WindowHeader {
    iconText: ""
    text: "Clip history"

    Item {
      Layout.fillWidth: true
      visible: !isEmpty
    }

    StyledButton {
      text: "Clear"
      padX: Theme.spacingSm
      padY: Theme.spacingXs
      pixelSize: Theme.fontSizeSm
      visible: !isEmpty

      onClicked: {
        PopoutManager.close()
        ClipManager.clear()
      }
    }
  }

  StyledListView {
    id: histories

    Layout.preferredWidth: Theme.spacingMd * 42
    Layout.preferredHeight: Math.min(contentHeight, Theme.spacingMd * 40)
    entries: ClipManager.history

    delegate: Wrapper {
      id: history

      required property var modelData
      required property int index
      readonly property bool highlighted: ListView.isCurrentItem
      property color foregroundColor: highlighted ? Theme.colors.on_primary_container : Theme.colors.on_surface
      property color backgroundColor: highlighted ? Theme.colors.primary_container : 'transparent'

      width: ListView.view.width
      padX: Theme.spacingMd
      padY: Theme.spacingSm
      color: backgroundColor

      function pick(): void {
        ClipManager.pick(history.modelData.id)
        PopoutManager.close()
      }

      ColumnLayout {
        spacing: 0

        StyledText {
          Layout.fillWidth: true
          Layout.preferredWidth: history.width - history.padX * 2

          text: history.modelData.preview
          wrapMode: Text.WordWrap
          maximumLineCount: 3
          elide: Text.ElideRight
        }
      }

      StyledListView.DelegateHoverHandler {
        view: histories
        index: history.index
      }

      TapHandler {
        onTapped: history.pick()
      }
    }
  }

  Shortcut {
    sequences: ["Return", "Enter"]
    enabled: histories.currentItem !== null
    onActivated: histories.currentItem.pick()
  }

  Component.onCompleted: {
    ClipManager.refresh()
  }
}
