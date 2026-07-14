import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.modules.bar

Pill {
  RowLayout {
    spacing: Theme.spacingMd

    Audio {}
    Network {}
    Battery {}
  }
}
