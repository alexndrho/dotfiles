import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.config
import qs.components
import qs.services
import qs.modules.bar

PanelWindow {
  id: root

  anchors { top: true; bottom: true; left: true; right: true }

  readonly property bool activePopoutNeedsInput: PopoutManager.activePopout !== ""
  && PopoutManager.activePopout !== "volume-osd"

  WlrLayershell.keyboardFocus:
  activePopoutNeedsInput
  ? WlrKeyboardFocus.Exclusive
  : WlrKeyboardFocus.None

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  mask: Region {
    id: windowInputMask

    Region {
      id: topRightInputRegion
      item: popoutTopRight.opened ? popoutTopRight : null
    }

    Region {
      id: bottomCenterInputRegion
      item: popoutBottomCenter.opened && root.activePopoutNeedsInput ? popoutBottomCenter : null
    }
  }

  // Popouts
  Popout {
    id: popoutTopRight

    anchors {
      top: parent.top
      right: parent.right
    }

    opened: notificationPopouts.notifications.length > 0
    implicitWidth: Theme.spacingXl * 15
    onSlideProgressChanged: topRightInputRegion.changed()

    NotificationPopouts {
      id: notificationPopouts
      anchorWindow: root
    }
  }

  Popout {
    id: popoutBottomCenter

    anchors {
      horizontalCenter: parent.horizontalCenter
      bottom: parent.bottom
    }

    opened: popoutLoader.item !== null
    onSlideProgressChanged: bottomCenterInputRegion.changed()

    child: Loader {
      id: popoutLoader

      sourceComponent: ({
          launcher: launcherPopout,
          cliphist: clipHistoryPopout,
          wallpaper: wallpaperPopout,
          "volume-osd": volumeOsd
      })[PopoutManager.activePopout] || null
    }

    Component {
      id: launcherPopout

      Launcher {}
    }

    Component {
      id: clipHistoryPopout

      ClipHistoryPopout {}
    }

    Component {
      id: wallpaperPopout

      WallpaperPopout {
        anchorWindow: root
      }
    }

    Component {
      id: volumeOsd

      VolumeOsd {}
    }
  }

  Shortcut {
    sequence: "Escape"
    enabled: PopoutManager.activePopout !== ""
    onActivated: PopoutManager.close()
  }
}
