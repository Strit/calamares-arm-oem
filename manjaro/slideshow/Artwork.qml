import QtQuick 2.15

Item {
    SystemPalette {
        id: systemPalette
    }
    property int rocketLift: 0

    id: root
    Image {
        id: background
        anchors {
            fill: parent
            margins: -10
            bottomMargin: 20
        }

        source: systemPalette.window.hslLightness > 0.5 ? "background.svg" : "background_dark.svg"
        sourceSize.width: width
        sourceSize.height: height

        SequentialAnimation {
            loops: Animation.Infinite
            running: true

            XAnimator{
                target: background
                from: -20
                to: 0
                duration: 5000
            }
            XAnimator {
                target: background
                from: 0
                to: -20
                duration: 5000
            }
        }
    }

    Rectangle {
            id: smoke
            anchors{
                bottom: parent.bottom
                right: parent.right
                left: parent.left
            }
            height: 57

            color: "#eff0f1"

            Image {
                anchors{
                    bottom: parent.bottom
                    left: parent.left
                }

                source: "smoke.svg"
                sourceSize.width: width
                sourceSize.height: height
            }
    }

    Image {
        id: rocket
        anchors {
            bottom: parent.bottom
            bottomMargin: -(height-rocketLift)
            left: parent.left
            leftMargin: 105
        }
        width: 100

        source: "rocket_smoke.svg"
        sourceSize.width: width
        sourceSize.height: height

        Behavior on anchors.bottomMargin {
            NumberAnimation {
                duration: 1400
                easing.type: Easing.OutQuad
            }
        }

    }


}
