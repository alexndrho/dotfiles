pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
  id: root
  property real level: 50
  property int stepSize: 5
  property string icon: ""

  function change(level) {
    brightnessProc.exec(["brightnessctl", "-m", "set", level])
  }

  function set(level) {
    change(level + "%")
  }

  function increase() {
    change(`+${stepSize}%`)
  }

  function decrease() {
    const nextLevel = level - stepSize
    if (nextLevel <= 0) return

    set(nextLevel)
  }

  Process {
    id: brightnessProc
    running: true
    command: ["brightnessctl", "-m"]
    stdout: StdioCollector {
      onStreamFinished: {
        const parts = this.text.trim().split(',')
        const levelIndex = 3

        if (parts.length <= levelIndex) return

        const level = parseInt(parts[levelIndex])
        if (!isNaN(level)) root.level = level
      }
    }
  }

  IpcHandler {
    target: "brightness"

    function set(level: int): void { root.set(level) }
    function increase(): void { root.increase() }
    function decrease(): void { root.decrease() }
  }
}
