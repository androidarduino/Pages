import QtQuick 2.2

Rectangle {
    width: 1024
    height: 768

    Component.onCompleted: {
        console.log("requesting weather");
        var http = new XMLHttpRequest();
        http.onreadystatechange = function () {
            if (http.readyState === XMLHttpRequest.DONE) {
                console.log(http.responseText);
                var result = eval('(' + http.responseText + ')');
                console.log(result);
                temperature.text = (result.main.temp - 273).toFixed(1) + "°C";
                humidity.text = "Humidity: " + (result.main.humidity).toFixed(1) + "%";
                air_pressure.text = (result.main.pressure).toFixed(1) + "Kpa";
                var sunrise = new Date(result.sys.sunrise*1000);
                var sunset = new Date(result.sys.sunset*1000);
                sun_rise_set.text = "Rise:  %1:%2\nSet: %3:%4".replace("%1", sunrise.getHours()).replace("%2", sunrise.getMinutes()).replace("%3", sunset.getHours()).replace("%4", sunset.getMinutes());
                min_max.text = "Min: " + (result.main.temp_min - 273).toFixed(1) + ", Max: " + (result.main.temp_max - 273).toFixed(1);
                cloud.text = result.clouds.all + "% Clouds";
                city.text = result.name + ", " + result.sys.country;
                weather_icon.source = ("icons/10.svg").replace("%icon", result.weather[0].icon);
                wind.text = ("speed: %1 \ngust: %2 \ndegree: %3").replace("%1", result.wind.speed).replace("%2", result.wind.gust).replace("%3", result.wind.deg);
            }
        }
        http.open("GET", "http://api.openweathermap.org/data/2.5/weather?q=Brisbane,au");
        http.send();

    }

    Rectangle {
        x: 0
        y: 0
        width: 721
        height: 74
        color: "#ffffff"
        Row {
            Text {
                id: humidity
                text: "humidity"
                verticalAlignment: "AlignVCenter"
                horizontalAlignment: "AlignLeft"
                font.pointSize: 19
            }
            Text {
                id: air_pressure
                text: "air_pressure"
                verticalAlignment: "AlignVCenter"
                horizontalAlignment: "AlignLeft"
                font.pointSize: 19
            }
        }
    }

    Rectangle {
        x: 0
        y: 73
        width: 721
        height: 329
        color: "#ffffff"
        Text {
            id: temperature
            text: "temperature"
            anchors.fill: parent
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignLeft"
            font.pointSize: 72
        }
    }

    Rectangle {
        x: 0
        y: 402
        width: 721
        height: 200
        color: "#ffffff"
        Text {
            text: "min_max"
            id: min_max
            anchors.fill: parent
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignLeft"
            font.pointSize: 32
        }
    }

    Rectangle {
        x: 494
        y: 603
        width: 227
        height: 165
        color: "#ffffff"
        Text {
            id: sun_rise_set
            text: "sun_rise_set"
            anchors.fill: parent
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignLeft"
            font.pointSize: 19
        }
    }

    Rectangle {
        x: 721
        y: 0
        width: 303
        height: 274
        color: "#ffffff"

        Image {
            id: weather_icon
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
            x: 77
            y: 124
            source: ""
        }
    }

    Rectangle {
        x: 0
        y: 603
        width: 493
        height: 164
        color: "#ffffff"
        Text {
            id: city
            text: "city"
            anchors.fill: parent
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignLeft"
            font.pointSize: 48
        }
    }

    Rectangle {
        x: 722
        y: 275
        width: 302
        height: 229
        color: "#ffffff"
        Text {
            id: wind
            text: "wind"
            anchors.fill: parent
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignLeft"
            font.pointSize: 19
        }
    }

    Rectangle {
        x: 722
        y: 504
        width: 302
        height: 265
        color: "#ffffff"
        Text {
            id: cloud
            text: "cloud"
            anchors.fill: parent
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignLeft"
            font.pointSize: 19
        }
    }

}

