pragma Singleton
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
  id: root
  readonly property var sink: Pipewire.defaultAudioSink
  readonly property var sinkAudio: sink ? sink.audio : null
  readonly property int volume: sinkAudio
  ? Math.round(sinkAudio.volume * 100)
  : 0
  readonly property bool muted: !sinkAudio || sinkAudio.muted
  property int stepSize: 5

  readonly property string icon: {
    if (muted) return "󰸈"
    if (volume >= 67) return "󰕾"
    if (volume >= 34) return "󰖀"
    return "󰕿"
  }

  function set(volume) {
    if (!sinkAudio) return

    sinkAudio.volume = Math.max(0, Math.min(volume, 100)) / 100
  }

  function increase() {
    set(volume + stepSize)
  }

  function decrease() {
    set(volume - stepSize)
  }

  PwObjectTracker {
    objects: [root.sink]
  }
}
