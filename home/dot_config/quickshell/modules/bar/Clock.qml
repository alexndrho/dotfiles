import Quickshell
import QtQuick

import qs.config
import qs.components

Pill {
  StyledText {
    SystemClock {
      id: clock
      precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, "h:mm A • ddd, MMMM d")
  }
}
