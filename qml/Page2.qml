import QtQuick 2.0

    Loader { id: pageLoader }


Rectangle {
    width: 100
    height: 62
	Column {
    Text {

        text: "page 2"
    }
	Text {
		background-color: yellow
		text: "go back"
		MouseArea {
		anchors.fill: parent
		onClicked: pageLoader.source = "https://raw.githubusercontent.com/androidarduino/Pages/master/qml/Page1.qml"
	}
	}
	}
}

