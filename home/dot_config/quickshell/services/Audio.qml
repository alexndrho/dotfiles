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

  readonly property string icon: {
    if (muted) return "󰖁"
    if (volume >= 67) return "󰕾"
    if (volume >= 34) return "󰖀"
    return "󰕿"
  }

  PwObjectTracker {
    objects: [root.sink]
  }
}
