import QtQuick 2.0

    Loader { id: pageLoader }


Rectangle {
    width: 100
    height: 62
	Column {
    Text {

        text: "page 1"
    }
	Text {
		background-color: yellow
		text: "go back"
		MouseArea {
		anchors.fill: parent
		onClicked: pageLoader.source = "qml/Arduino/main.qml"
	}
	}
	}
}

