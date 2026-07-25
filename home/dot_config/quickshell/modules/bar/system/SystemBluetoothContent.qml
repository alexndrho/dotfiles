import Quickshell
import Quickshell.Bluetooth as QsBluetooth
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components
import qs.services

ColumnLayout {
  id: root
  spacing: Theme.spacingMd

  signal backClicked()

  PopupHeader {
    title: "Bluetooth"
    showBackButton: true
    onBackClicked: root.backClicked()
  }

  RowLayout {
    spacing: Theme.spacingMd

    StyledText {
      Layout.alignment: Qt.AlignVCenter
      text: "Bluetooth"
    }

    Item {
      Layout.fillWidth: true
    }

    StyledSwitch {
      Layout.alignment: Qt.AlignVCenter
      checked: BluetoothManager.enabled
      onToggled: (checked) => BluetoothManager.setEnabled(checked)
    }
  }

  ColumnLayout {
    spacing: Theme.spacingMd

    Repeater {
      model: BluetoothManager.devices

      delegate: Rectangle {
        id: bluetoothItem
        Layout.fillWidth: true
        required property var modelData
        readonly property bool busy: (
          modelData.pairing
          || modelData.state === QsBluetooth.BluetoothDeviceState.Connecting
          || modelData.state === QsBluetooth.BluetoothDeviceState.Disconnecting
        )
        property bool connectAfterPairing: false
        property int padX: Theme.spacingMd
        property int padY: Theme.spacingSm
        property bool hovered: bluetoothItemHoverHandler.hovered

        implicitWidth: bluetoothItemContent.implicitWidth + padX * 2
        implicitHeight: bluetoothItemContent.implicitHeight + padY * 2
        color: hovered ? Theme.bg3 : Theme.bg0
        radius: Theme.radiusMd

        function toggleConnection(): void {
          if (busy)
            return

          connectAfterPairing = false

          if (modelData.connected) {
            modelData.disconnect()
          } else if (modelData.paired) {
            modelData.connect()
          } else {
            connectAfterPairing = true
            modelData.pair()
          }
        }

        Connections {
          target: bluetoothItem.modelData

          function onPairingChanged(): void {
            if (bluetoothItem.modelData.pairing
                || !bluetoothItem.connectAfterPairing)
              return

            bluetoothItem.connectAfterPairing = false

            if (bluetoothItem.modelData.paired
                && !bluetoothItem.modelData.connected)
              bluetoothItem.modelData.connect()
          }
        }

        RowLayout {
          id: bluetoothItemContent
          anchors {
            fill: parent
            leftMargin: bluetoothItem.padX
            rightMargin: bluetoothItem.padX
            topMargin: bluetoothItem.padY
            bottomMargin: bluetoothItem.padY
          }
          spacing: Theme.spacingMd

          StyledText {
            text: modelData.name
          }

          Item {
            Layout.fillWidth: true
          }

          Spinner {
            visible: bluetoothItem.busy
          }

          StyledText {
            text: ""
            visible: !bluetoothItem.busy && modelData.connected
          }
        }

        HoverHandler {
          id: bluetoothItemHoverHandler
        }

        MouseArea {
          anchors.fill: parent
          enabled: !bluetoothItem.busy
          cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
          onClicked: bluetoothItem.toggleConnection()
        }
      }
    }
  }
}
