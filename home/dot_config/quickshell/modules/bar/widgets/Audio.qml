import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

import qs.config
import qs.components

Item {
  id: audio

  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight

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
    objects: [audio.sink]
  }

  StyledText {
    id: label
    text: audio.icon
    font.pixelSize: Theme.fontSizeLg
    color: audio.muted ? Theme.fg3 : Theme.fg0
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      if (audio.sinkAudio) audio.sinkAudio.muted = !audio.sinkAudio.muted
    }
  }
}
