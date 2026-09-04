pragma Singleton
import Quickshell
import Quickshell.Io
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

  function increase() {
    set(volume + stepSize)
    showOsd()
  }

  function decrease() {
    set(volume - stepSize)
    showOsd()
  }

  function toggleMute() {
    if (!sinkAudio) return
    sinkAudio.muted = !sinkAudio.muted
    showOsd()
  }

  function showOsd() {
    PopoutManager.open("volume-osd")
    hideTimer.restart()
  }

  PwObjectTracker {
    objects: [root.sink]
  }

  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: PopoutManager.close("volume-osd")
  }

  IpcHandler {
    target: "audio"

    function increase() {
      root.increase()
    }

    function decrease() {
      root.decrease()
    }

    function toggleMute() {
      root.toggleMute()
    }
  }
}
