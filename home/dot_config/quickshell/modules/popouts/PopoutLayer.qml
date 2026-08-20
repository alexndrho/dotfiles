import Quickshell
import qs.modules.bar

PanelWindow {
  id: root

  anchors { top: true; bottom: true; left: true; right: true }

  color: "transparent"
  exclusionMode: ExclusionMode.Ignore

  mask: Region {
    id: windowInputMask

    Region {
      item: wallpaperPopout.visible ? wallpaperPopout : null
    }
  }

  // Popouts
  NotificationPopouts {
    anchorWindow: root
    inputMask: windowInputMask
  }

  WallpaperPopout {
    id: wallpaperPopout
    anchorWindow: root
  }
}
