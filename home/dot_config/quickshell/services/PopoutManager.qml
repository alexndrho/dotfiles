pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property string activePopout: ""

  function toggle(popout: string): void {
    activePopout = popout !== activePopout ? popout : ""
  }

  function close(): void {
    root.activePopout = ""
  }

  IpcHandler {
    target: "popout"

    function toggle(popout: string): void {
      root.toggle(popout)
    }
  }
}
