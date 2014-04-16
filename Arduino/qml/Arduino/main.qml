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
import QtBluetooth 5.2 as Bluetooth
import QtQuick.XmlListModel 2.0 as XML

Item {
    width: 200; height: 200

    Text {
        text: "test"
    }

    Loader { id: pageLoader }

    MouseArea {
        anchors.fill: parent
        onClicked: pageLoader.source = "https://raw.githubusercontent.com/androidarduino/Pages/master/Pages/Page1.qml"
    }
}




































