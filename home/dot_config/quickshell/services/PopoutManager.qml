pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property string activePopout: ""

  function open(popout: string) {
    activePopout = popout
  }

  function toggle(popout: string): void {
    activePopout = popout !== activePopout ? popout : ""
  }

  function close(popout): void {
    if (popout) {
      if (popout === activePopout) {
        root.activePopout = ""
      }
    } else {
      root.activePopout = ""
    }
  }

  IpcHandler {
    target: "popout"

    function toggle(popout: string): void {
      root.toggle(popout)
    }
  }
}
