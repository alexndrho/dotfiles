pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property var history: []

  function pick(id: string): void  {
    proc.command = [
    "sh",
    "-c",
    "cliphist decode \"$1\" | wl-copy",
    "cliphist-pick",
    id
    ]

    proc.running = true
  }

  function refresh(): void {
    listProc.running = true
  }

  function clear(): void {
    if (!wipeProc.running)
    wipeProc.running = true
  }

  Process {
    id: proc
  }

  Process {
    id: listProc
    running: true
    command: ["cliphist", "list"]
    stdout: StdioCollector {
      onStreamFinished: {
        root.history = this.text.split("\n")
        .filter(line => line.length > 0)
        .map(line => {
            const [id, ...parts] = line.split("\t")
            const preview = parts.join("\t")

            return {
              id: id,
              preview: preview,
              isImage: preview.startsWith("[[ binary data")
            }
        })
        .sort((a, b) => Number(b.id) - Number(a.id))
      }
    }
  }

  Process {
    id: wipeProc
    command: ["cliphist", "wipe"]

    onExited: (exitCode, exitStatus) => {
      if (exitCode === 0)
      root.history = []
    }
  }
}
