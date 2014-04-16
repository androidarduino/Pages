import QtQuick 2.0



Rectangle {
    width: 100
    height: 62
    Loader { id: pageLoader }
	Column {
    Text {

        text: "page 1"
    }
	Text {
		background-color: yellow
		text: "go back"
		MouseArea {
		anchors.fill: parent
		onClicked: pageLoader.source = "https://raw.githubusercontent.com/androidarduino/Pages/master/qml/Page2.qml"
	}
	}
	}
}

