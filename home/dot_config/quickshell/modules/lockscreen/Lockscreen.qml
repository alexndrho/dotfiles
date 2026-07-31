import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Scope {
  LockContext {
    id: lockContext

    onUnlocked: {
      lock.locked = false;
    }
  }

  WlSessionLock {
    id: lock

    WlSessionLockSurface {
      LockSurface {
        anchors.fill: parent
        context: lockContext
      }
    }
  }

  IpcHandler {
    target: "lockscreen"

    function activate(): void {
      lock.locked = true;
    }
  }
}
