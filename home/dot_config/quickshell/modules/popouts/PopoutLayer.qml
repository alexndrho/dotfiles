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

  WlrLayershell.keyboardFocus:
  PopoutManager.activePopout !== ""
  ? WlrKeyboardFocus.Exclusive
  : WlrKeyboardFocus.None

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  mask: Region {
    id: windowInputMask

    Region {
      item: popoutBottomCenter.opened ? popoutBottomCenter : null
    }
  }

  // Popouts
  NotificationPopouts {
    anchorWindow: root
    inputMask: windowInputMask
  }

  Shortcut {
    sequence: "Escape"
    enabled: PopoutManager.activePopout !== ""
    onActivated: PopoutManager.close()
  }

  Popout {
    id: popoutBottomCenter

    anchors {
      horizontalCenter: parent.horizontalCenter
      bottom: parent.bottom
      bottomMargin: Theme.spacingMd
    }

    opened: popoutLoader.item !== null
    transformOrigin: Item.Bottom

    child: Loader {
      id: popoutLoader

      sourceComponent: ({
          launcher: launcherPopout,
          wallpaper: wallpaperPopout
      })[PopoutManager.activePopout] || null
    }

    Component {
      id: launcherPopout

      Launcher {}
    }

    Component {
      id: wallpaperPopout

      WallpaperPopout {
        anchorWindow: root
      }
    }
  }
}
