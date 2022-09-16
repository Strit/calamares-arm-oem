import QtQuick 2.15
Item {

    property bool showSmoke: false

    Item {
        id: rocketNoSmoke
        property bool rocketFrame: false

        Timer {
            interval: 200
            running: !showSmoke
            repeat: true
            onTriggered: rocketNoSmoke.rocketFrame = !rocketNoSmoke.rocketFrame
        }
        width: 250
        height: Math.min(rocket_a.paintedHeight, rocket_b.paintedHeight)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        Image {
            opacity: rocketNoSmoke.rocketFrame?1:0
            width: parent.width
            id: rocket_a
            fillMode: Image.PreserveAspectFit

            source: "rocket_a.svg"

        }

        Image {
            opacity: rocketNoSmoke.rocketFrame?0:1
            width: parent.width
            id: rocket_b
            fillMode: Image.PreserveAspectFit

            source: "rocket_b.svg"

        }
    }



    Image {
        opacity: showSmoke?1:0
        width: 250
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        id: rocketSmoke
        fillMode: Image.PreserveAspectFit

        source: "rocket_smoke.svg"

        Behavior on opacity {
            NumberAnimation{}
        }
    }

}
