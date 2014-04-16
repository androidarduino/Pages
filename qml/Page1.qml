import QtQuick 2.0

Rectangle {
    width: 100
    height: 62
	Column {
    Text {

        text: "page 1"
    }
	Text {
		text: "go back"
		MouseArea {
		anchors.fill: parent
		onClicked: pageLoader.source = "qml/Arduino/main.qml"
	}
	}
	}
}

