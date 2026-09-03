pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Pipewire

Singleton {
  id: root
  readonly property var sink: Pipewire.defaultAudioSink
  readonly property var sinkAudio: sink ? sink.audio : null
  readonly property int volume: sinkAudio ? Math.round(sinkAudio.volume * 100) : 0
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

  function showOsd() {
    PopoutManager.open("volume-osd")
    hideTimer.restart()
  }

  PwObjectTracker {
    objects: [root.sink]
  }

  Connections {
    target: root.sinkAudio

    function onVolumeChanged() {
      root.showOsd()
    }

    function onMutedChanged() {
      root.showOsd()
    }
  }

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: PopoutManager.close("volume-osd")
  }
}
