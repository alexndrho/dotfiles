import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.config
import qs.components
import qs.services

ColumnLayout {
  id: root

  property string query
  property bool keyboardNavigation: false

  spacing: Theme.spacingMd

  function launchSelected() {
    if (entriesList.currentItem?.modelData) {
      entriesList.currentItem.modelData.execute()
      PopoutManager.close()
    }
  }

  WindowHeader {
    iconText: "󰝘"
    text: "Launcher"
  }

  StyledTextInput {
    id: queryInput

    Layout.preferredWidth: Theme.spacingMd * 42
    input.text: root.query
    input.onTextEdited: root.query = input.text
    placeholderText: "Search"
    onAccepted: root.launchSelected()

    Component.onCompleted: {
      Qt.callLater(() => queryInput.input.forceActiveFocus())
    }
  }

  ScriptModel {
    id: entries

    values: {
      const all = [...DesktopEntries.applications.values]
      .filter(entry => entry.name)
      .sort((a, b) => a.name.localeCompare(b.name));

      const query = root.query.trim().toLowerCase();

      if (query === "") return all;

      return all.filter(entry => {
          const name = (entry.name || "").toLowerCase();
          const comment = (entry.comment || "").toLowerCase();
          const keywords = (entry.keywords || []).join(" ").toLowerCase();
          const categories = (entry.categories || []).join(" ").toLowerCase();

          return name.includes(query) || comment.includes(query)
          || keywords.includes(query) || categories.includes(query);
      });
    }
  }

  StyledListView {
    id: entriesList
    Layout.fillWidth: true
    Layout.preferredHeight: Math.min(contentHeight, Theme.spacingMd * 40)

    entries: entries.values

    delegate: Wrapper {
      id: entry

      required property var modelData
      required property int index
      readonly property bool highlighted: ListView.isCurrentItem
      property color foregroundColor: highlighted ? Theme.colors.on_primary_container : Theme.colors.on_surface
      property color backgroundColor: highlighted ? Theme.colors.primary_container : 'transparent'

      width: ListView.view.width
      padX: Theme.spacingMd
      padY: Theme.spacingSm
      color: entry.backgroundColor

      RowLayout {
        Layout.fillWidth: true
        spacing: Theme.spacingMd

        IconImage {
          implicitSize: Theme.spacingXl * 1.75
          visible: !!entry.modelData.icon
          source: entry.modelData.icon
          ? Quickshell.iconPath(entry.modelData.icon)
          : ""
        }

        ColumnLayout {
          Layout.fillWidth: true

          StyledText {
            Layout.fillWidth: true
            text: entry.modelData.name
            color: entry.foregroundColor
            elide: Text.ElideRight
          }

          StyledText {
            Layout.fillWidth: true
            text: entry.modelData.comment
            color: Theme.colors.on_surface_variant

            elide: Text.ElideRight
            visible: !!entry.modelData.comment
          }
        }
      }

      StyledListView.DelegateHoverHandler {
        view: entriesList
        index: entry.index
      }

      TapHandler {
        onTapped: {
          entry.modelData.execute()
          PopoutManager.close()
        }
      }
    }
  }
}
