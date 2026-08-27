pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import qs.helpers

Singleton {
  id: root

  property string icon: ""
  property string tempC: "--"
  property string interval: 15 * 60 * 1000

  function setWeatherError(message) {
    root.icon = ""
    root.tempC = "--"
    console.warn("Weather:", message)
  }

  Process {
    id: weatherProc
    running: true
    command: [Quickshell.shellPath("scripts/weather.sh")]

    stdout: StdioCollector {
      id: weatherStdout
    }

    stderr: StdioCollector {
      id: weatherStderr
    }

    onExited: (exitCode, exitStatus) => {
      if (exitCode !== 0) {
        const error = weatherStderr.text.trim()
        root.setWeatherError(error || "Weather request failed")
        return
      }

      const output = weatherStdout.text.trim()

      if (!output) {
        root.setWeatherError("No response received")
        return
      }

      try {
        const parsed = JSON.parse(output)
        const current = parsed.current_condition?.[0]

        if (
          !current
          || current.weatherCode === undefined
          || current.temp_C === undefined
        ) {
          root.setWeatherError("Invalid weather response")
          return
        }

        root.icon = IconUtils.weatherIconCode(current.weatherCode)
        root.tempC = current.temp_C
      } catch (error) {
        root.setWeatherError("Could not parse response: " + error)
      }
    }
  }

  Timer {
    interval: root.interval
    running: true
    repeat: true
    onTriggered: weatherProc.running = true
  }
}
