import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.components

Column {
  id: root

  required property var anchorWindow
  required property var inputMask
  property int animationDuration: Theme.animationDurationLg
  property int maxNotifications: 5

  anchors {
    top: parent.top
    right: parent.right
    margins: Theme.spacingMd
  }

  width: Theme.spacingXl * 15
  spacing: Theme.spacingMd

  NotificationServer {
    id: notificationServer

    imageSupported: true
    actionsSupported: true

    onNotification: (notification) => {
      notification.tracked = true
    }
  }

  Repeater {
    model: ScriptModel {
      values: [...notificationServer.trackedNotifications.values]
      .reverse()
      .slice(0, root.maxNotifications)
    }

    delegate: Wrapper {
      id: trackedNotification

      required property var modelData
      readonly property Region inputRegion: Region {
        item: trackedNotification
      }

      readonly property int defaultTimeout: 10000
      property bool closing: false
      property var afterCloseAnimationAction: null

      width: root.width

      Component.onCompleted: {
        root.inputMask.regions.push(inputRegion)
        openAnimation.start()
      }

      function animateThenClose(action): void {
        if (closing)
        return

        closing = true
        expiryTimer.stop()
        openAnimation.stop()
        afterCloseAnimationAction = action
        closeAnimation.restart()
      }

      function dismissNotification(): void {
        animateThenClose(() => modelData.dismiss())
      }

      function activateNotification(): void {
        const actions = modelData.actions

        for (let i = 0; i < actions.length; ++i) {
          if (actions[i].identifier === "default") {
            if (closing) return

            const defaultAction = actions[i]

            if (modelData.resident) {
              defaultAction.invoke()
              return
            }

            animateThenClose(() => defaultAction.invoke())
            break
          }
        }

        dismissNotification()
      }

      child: RowLayout {
        id: notificationContent
        spacing: Theme.spacingMd

        Image {
          readonly property int imageSize: Theme.spacingXl * 1.75

          readonly property string displaySource: {
            const notification = trackedNotification.modelData
            const image = notification.image.toString()

            // Prefer notification-specific images, such as Discord avatars.
            if (image)
            return image

            const appIcon = notification.appIcon.toString()
            const isFile = appIcon.startsWith("file:") || appIcon.startsWith("/")

            // Niri provides the captured screenshot through appIcon as a file path.
            if (notification.appName === "niri" && isFile)
            return appIcon

            // Find the application's desktop entry to obtain its themed icon name.
            const entry = DesktopEntries.heuristicLookup(
              notification.desktopEntry || notification.appName
            )

            // Prefer the desktop-entry icon. Otherwise, use appIcon only when
            // it is an icon name—not a direct file that would bypass Papirus.
            const iconName = entry?.icon || (isFile ? "" : appIcon)

            // Resolve the icon name through the configured system icon theme.
            return iconName ? Quickshell.iconPath(iconName, true) : ""
          }

          Layout.preferredWidth: imageSize
          Layout.preferredHeight: imageSize
          Layout.alignment: Qt.AlignTop

          source: displaySource
          sourceSize.width: Math.ceil(imageSize * anchorWindow.devicePixelRatio)
          sourceSize.height: Math.ceil(imageSize * anchorWindow.devicePixelRatio)

          fillMode: Image.PreserveAspectFit
          asynchronous: true
          smooth: true
          visible: displaySource.length > 0
        }

        ColumnLayout {
          Layout.fillWidth: true
          Layout.alignment: Qt.AlignTop
          spacing: Theme.spacingXs

          StyledText {
            Layout.fillWidth: true
            font.bold: true
            text: trackedNotification.modelData.summary
            wrapMode: Text.Wrap
            maximumLineCount: 3
            elide: Text.ElideRight
            visible: text.trim().length > 0
          }

          StyledText {
            Layout.fillWidth: true
            text: trackedNotification.modelData.body
            wrapMode: Text.Wrap
            maximumLineCount: 3
            elide: Text.ElideRight
            visible: text.trim().length > 0
          }
        }
      }

      PauseAnimation {
        id: expiryTimer
        readonly property real timeout:
        trackedNotification.modelData.expireTimeout

        duration: timeout > 0 ? timeout : trackedNotification.defaultTimeout
        running: timeout !== 0
        paused: hoverHandler.hovered

        onFinished: trackedNotification.animateThenClose(
          () => trackedNotification.modelData.expire()
        )
      }

      HoverHandler {
        id: hoverHandler
        parent: trackedNotification
      }

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: mouse => {
          if (mouse.button === Qt.RightButton)
          trackedNotification.dismissNotification()
          else
          trackedNotification.activateNotification()
        }
      }

      Connections {
        target: trackedNotification.modelData

        function restartExpiry() {
          if (expiryTimer.timeout !== 0)
          expiryTimer.restart()
        }

        function onSummaryChanged() { restartExpiry() }
        function onBodyChanged() { restartExpiry() }
        function onImageChanged() { restartExpiry() }
        function onAppIconChanged() { restartExpiry() }
        function onHintsChanged() { restartExpiry() }
        function onActionsChanged() { restartExpiry() }
        function onExpireTimeoutChanged() { restartExpiry() }
      }

      ParallelAnimation {
        id: openAnimation

        NumberAnimation {
          target: trackedNotification
          property: "scale"
          from: Theme.popoutClosedScale
          to: 1
          duration: root.animationDuration
          easing.type: Easing.OutCubic
        }

        NumberAnimation {
          target: trackedNotification
          property: "opacity"
          from: 0
          to: 1
          duration: root.animationDuration
          easing.type: Easing.OutCubic
        }
      }

      ParallelAnimation {
        id: closeAnimation

        NumberAnimation {
          target: trackedNotification
          property: "scale"
          from: 1
          to: Theme.popoutClosedScale
          duration: root.animationDuration
          easing.type: Easing.InCubic
        }

        NumberAnimation {
          target: trackedNotification
          property: "opacity"
          from: 1
          to: 0
          duration: root.animationDuration
          easing.type: Easing.InCubic
        }

        onFinished: {
          const action = trackedNotification.afterCloseAnimationAction
          trackedNotification.afterCloseAnimationAction = null

          if (action) action()
        }
      }
    }
  }

  move: Transition {
    NumberAnimation {
      properties: "y"
      duration: root.animationDuration
      easing.type: Easing.OutCubic
    }
  }
}
