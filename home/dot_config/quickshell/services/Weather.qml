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

  function timeToMinutes(time: string): int {
    const [clock, period] = time.split(" ")
    let [hours, minutes] = clock.split(":").map(Number)

    hours = (hours % 12) + (period === "PM" ? 12 : 0)

    return hours * 60 + minutes
  }

  function isDaytime(astronomy: var): bool {
    if (
      !astronomy
      || typeof astronomy.sunrise !== "string"
      || typeof astronomy.sunset !== "string"
    ) {
      return true
    }

    const sunrise = root.timeToMinutes(astronomy.sunrise)
    const sunset = root.timeToMinutes(astronomy.sunset)

    if (
      !Number.isFinite(sunrise)
      || !Number.isFinite(sunset)
      || sunrise < 0
      || sunset < 0
    ) {
      return true
    }

    const now = new Date()
    const currentTime = now.getHours() * 60 + now.getMinutes()
    return currentTime >= sunrise && currentTime < sunset
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
        const astronomy = parsed.weather?.[0]?.astronomy?.[0]

        if (
          !current
          || current.weatherCode === undefined
          || current.temp_C === undefined
        ) {
          root.setWeatherError("Invalid weather response")
          return
        }

        root.icon = IconUtils.weatherIconCode(
          current.weatherCode,
          root.isDaytime(astronomy)
        )
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
