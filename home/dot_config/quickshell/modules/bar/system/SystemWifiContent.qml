import Quickshell
import Quickshell.Networking as QsNetworking
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material

import qs.config
import qs.components
import qs.services

ColumnLayout {
  id: root
  spacing: Theme.spacingMd

  signal backClicked()

  Component.onCompleted: Network.setScannerEnabled(true)
  Component.onDestruction: Network.setScannerEnabled(false)

  PopupHeader {
    title: "Wifi"
    showBackButton: true
    onBackClicked: root.backClicked()
  }

  RowLayout {
    spacing: Theme.spacingMd

    StyledText {
      Layout.alignment: Qt.AlignVCenter
      text: "Wifi"
    }

    Item {
      Layout.fillWidth: true
    }

    StyledSwitch {
      Layout.alignment: Qt.AlignVCenter
      checked: Network.wifiEnabled
      onToggled: (checked) => Network.setWifiEnabled(checked)
    }
  }

  ColumnLayout {
    id: wifiNetworks
    property int expandedWifiNetworkIndex: -1

    function expandWifiNetworkItem(index: int): void {
      wifiNetworks.expandedWifiNetworkIndex = index
    }

    function removeExpandedWifiNetwork(): void {
      wifiNetworks.expandedWifiNetworkIndex = -1
    }

    Repeater {
      model: Network.wifiNetworks
      delegate: Rectangle {
        id: wifiNetworkItem
        Layout.fillWidth: true
        required property var modelData
        required property int index
        readonly property bool expanded: wifiNetworks.expandedWifiNetworkIndex === index
        readonly property bool connecting:
        modelData.state === QsNetworking.ConnectionState.Connecting
        readonly property bool passwordless: (
          modelData.security === QsNetworking.WifiSecurityType.Open
          || modelData.security === QsNetworking.WifiSecurityType.Owe
        )
        property bool passwordPromptVisible: false
        property string connectionError: ""
        property int padX: Theme.spacingMd
        property int padY: Theme.spacingSm

        implicitWidth: wifiNetworkItemContent.implicitWidth
        implicitHeight: wifiNetworkItemContent.implicitHeight
        color: expanded || networkMouseArea.containsMouse ? Theme.bg3 : Theme.bg0
        radius: Theme.radiusMd

        function disconnect(): void {
          modelData.disconnect()
          wifiNetworks.removeExpandedWifiNetwork()
        }

        function resetConnectionForm(): void {
          passwordInput.clear()
          passwordPromptVisible = false
          connectionError = ""
        }

        function showPasswordPrompt(): void {
          passwordPromptVisible = true
          Qt.callLater(() => {
              if (wifiNetworkItem.expanded)
              passwordInput.forceActiveFocus()
          })
        }

        function connectOrPrompt(): void {
          wifiNetworks.expandWifiNetworkItem(index)

          if (modelData.connected)
          return

          resetConnectionForm()

          if (modelData.known || passwordless) {
            modelData.connect()
          } else {
            showPasswordPrompt()
          }
        }

        function connectWithPassword(): void {
          if (connecting || passwordInput.text.length === 0)
          return

          connectionError = ""
          modelData.connectWithPsk(passwordInput.text)
        }

        function connectionErrorMessage(reason: int): string {
          switch (reason) {
            case QsNetworking.ConnectionFailReason.NoSecrets:
            return "Password is required or incorrect."
            case QsNetworking.ConnectionFailReason.WifiClientDisconnected:
            return "Connection was interrupted. Please try again."
            case QsNetworking.ConnectionFailReason.WifiClientFailed:
            return "Couldn't connect. Check the password and try again."
            case QsNetworking.ConnectionFailReason.WifiAuthTimeout:
            return "Authentication timed out. Check the password and try again."
            case QsNetworking.ConnectionFailReason.WifiNetworkLost:
            return "This network is no longer available."
            default:
            return "Couldn't connect to this network."
          }
        }

        Connections {
          target: wifiNetworkItem.modelData

          function onConnectionFailed(reason): void {
            wifiNetworkItem.connectionError =
            wifiNetworkItem.connectionErrorMessage(reason)

            if (!wifiNetworkItem.passwordless)
            wifiNetworkItem.showPasswordPrompt()
          }

          function onConnectedChanged(): void {
            if (wifiNetworkItem.modelData.connected)
            wifiNetworkItem.resetConnectionForm()
          }
        }

        ColumnLayout {
          id: wifiNetworkItemContent
          anchors.fill: parent
          spacing: 0

          WrapperMouseArea {
            id: networkMouseArea
            Layout.fillWidth: true

            leftMargin: wifiNetworkItem.padX
            rightMargin: wifiNetworkItem.padX
            topMargin: wifiNetworkItem.padY
            bottomMargin: wifiNetworkItem.padY

            enabled: !wifiNetworkItem.expanded
            hoverEnabled:  true
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

            onClicked: {
              wifiNetworkItem.connectOrPrompt()
            }

            RowLayout {
              spacing: Theme.spacingSm

              StyledText {
                Layout.alignment: Qt.AlignVCenter
                text: Network.wifiIconForSignal(
                  Math.round(modelData.signalStrength * 100)
                )
              }

              StyledText {
                Layout.alignment: Qt.AlignVCenter
                text: wifiNetworkItem.modelData.name
              }

              Item {
                Layout.fillWidth: true
              }

              Spinner {
                visible: wifiNetworkItem.connecting
              }

              StyledText {
                text: ""
                visible: !wifiNetworkItem.connecting && wifiNetworkItem.modelData.connected
              }
            }
          }

          ColumnLayout {
            Layout.leftMargin: wifiNetworkItem.padX
            Layout.rightMargin: wifiNetworkItem.padX
            Layout.bottomMargin: wifiNetworkItem.padY

            visible: expanded && wifiNetworkItem.modelData.connected
            spacing: Theme.spacingMd

            RowLayout {
              spacing: Theme.spacingMd

              StyledButton {
                Layout.alignment: Qt.AlignRight
                visible: modelData.connected
                icon: "󰖪"
                label: "Disconnect"
                backgroundColor: Theme.red

                onClicked: {
                  wifiNetworkItem.disconnect()
                }
              }

              StyledButton {
                label: "Cancel"
                backgroundColor: Theme.bg0
                foregroundColor: Theme.fg0

                onClicked: {
                  wifiNetworks.removeExpandedWifiNetwork()
                }
              }
            }
          }

          ColumnLayout {
            Layout.leftMargin: wifiNetworkItem.padX
            Layout.rightMargin: wifiNetworkItem.padX
            Layout.bottomMargin: wifiNetworkItem.padY

            visible: expanded && !wifiNetworkItem.modelData.connected
            spacing: Theme.spacingMd

            StyledTextField {
              id: passwordInput
              Layout.fillWidth: true
              placeholderText: "Password"
              echoMode: TextInput.Password
              enabled: !wifiNetworkItem.connecting
              visible: wifiNetworkItem.passwordPromptVisible

              onAccepted: {
                wifiNetworkItem.connectWithPassword()
              }
            }

            StyledText {
              Layout.fillWidth: true
              text: wifiNetworkItem.connectionError
              color: Theme.red
              wrapMode: Text.WordWrap
              visible: text.length > 0
            }

            RowLayout {
              spacing: Theme.spacingMd

              StyledButton {
                icon: "󰤨"
                label: wifiNetworkItem.connecting ? "Connecting…" : "Connect"
                enabled: (
                  wifiNetworkItem.passwordPromptVisible
                  && !wifiNetworkItem.connecting
                  && passwordInput.text.length > 0
                )
                visible: wifiNetworkItem.passwordPromptVisible

                onClicked: {
                  wifiNetworkItem.connectWithPassword()
                }
              }

              StyledButton {
                label: "Cancel"
                backgroundColor: Theme.bg0
                foregroundColor: Theme.fg0
                enabled: !wifiNetworkItem.connecting

                onClicked: {
                  wifiNetworkItem.resetConnectionForm()
                  wifiNetworks.removeExpandedWifiNetwork()
                }
              }
            }
          }
        }
      }
    }
  }
}
