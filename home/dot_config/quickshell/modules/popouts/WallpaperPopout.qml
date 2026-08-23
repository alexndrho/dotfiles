import Quickshell
import Qt.labs.folderlistmodel
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import qs.config
import qs.components
import qs.services

ScrollView {
  id: root

  required property var anchorWindow
  property int wallpaperPerRow: 4
  property int cardWidth: Theme.spacingMd * 20
  property int cardHeight: cardWidth / 2
  property int cardGap: Theme.spacingMd

  property int wallpaperRowMax: 3
  implicitWidth: (cardWidth * wallpaperPerRow) + (cardGap * (wallpaperPerRow - 1))
  implicitHeight: (cardHeight * wallpaperRowMax) + (cardGap * (wallpaperRowMax - 1))
  + wallpaperLabel.implicitHeight + cardGap

  GridLayout {
    columns: root.wallpaperPerRow
    columnSpacing: root.cardGap
    rowSpacing: root.cardGap

    RowLayout {
      id: wallpaperLabel
      Layout.columnSpan: parent.columns
      Layout.fillWidth: true
      spacing: Theme.spacingXs

      StyledText {
        text: ""
        font.family: Theme.iconFontFamily
      }

      StyledText {
        text: "Wallpapers"
      }
    }

    Repeater {
      model: wallpapers

      delegate: Image {
        id: wallpaperImage
        required property url fileUrl
        required property string filePath

        Layout.preferredWidth: root.cardWidth
        Layout.preferredHeight: root.cardHeight
        source: fileUrl
        // sourceSize is measured in physical pixels. Match the output's
        sourceSize.width: Math.ceil(root.cardWidth * root.anchorWindow.devicePixelRatio)
        sourceSize.height: Math.ceil(root.cardHeight * root.anchorWindow.devicePixelRatio)
        asynchronous: true
        smooth: true
        fillMode: Image.PreserveAspectCrop

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor

          onClicked: {
            Appearance.wallpaper = wallpaperImage.filePath
            PopoutManager.close()
          }
        }
      }
    }
  }

  FolderListModel {
    id: wallpapers
    folder: "file://" + Quickshell.env("HOME") + "/Pictures/wallpapers/"
    showDirs: false
    nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
  }
}
