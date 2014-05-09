import QtQuick 2.2
import QtGraphicalEffects 1.0 as Graphical
import QtPositioning 5.2 as Positioning
import Qt.labs.settings 1.0 as Settings
import QtNfc 5.2 as NFC
import QtSensors 5.0 as Sensor
import QtMultimedia 5.0 as Multimedia
import QtQuick.Particles 2.0 as Particle
import QtQuick.Controls 1.1 as Controls
import QtQuick.Controls.Styles 1.1 as Styles
import QtQuick.Window 2.0 as Window
import QtQuick.Dialogs 1.1 as Dialogs
import QtQuick.Layouts 1.1 as Layouts
import QtQuick.LocalStorage 2.0 as SQL
import BTQML 1.0

//import QtBluetooth 5.2 as Bluetooth
//import QtQuick.XmlListModel 2.0 as XML

Item {
    width: 400; height: 600
    Column {
        id: column1
        anchors.fill: parent
        spacing: 32
        BTQML {
            id: btqml
            send_terminator: "*"
            receive_terminator: "\n"
            //encoding: "Latin1"
            //onReceivedLine: { console.log("Received: " + message); received.text = message }
            //TODO: implement the receiving signal
        }
        Controls.ComboBox{
            id: target_device
            width: 200
            height: 32
            model: btqml.paired_devices
            //model: ["abc","bcd", "efg"]
        }
        Controls.Button {
            width: 200
            height: 32
            text: "Connect"
            onClicked: btqml.connect(target_device.currentText)
        }
        TextEdit {
            id: message
            text: "2,0,255*"
            font.bold: true
            horizontalAlignment: TextEdit.AlignLeft
            font.pointSize: 12
        }
        Controls.Button {
            width: 200
            height: 32
            text: "Send"
            onClicked: {btqml.send_line(message.text);}
        }
        Text {
            id: received
            width: 200
        }
        Text {
            id: msg
            width: 200
        }
    }
}
