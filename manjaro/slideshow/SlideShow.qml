import QtQuick 2.15
import QtQml 2.15

Item {
    id: root

    function onActivate(){
        timer.restart();
        slider.reset();
        artwork.state = "nearGround";
    }

    function onLeave(){
    }

    width: 800
    height: 400

    Timer {
        id: timer
        interval: 20000
        running: false
        repeat: true
        onTriggered: slider.currentSlideIndex++
    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            timer.restart();
            slider.currentSlideIndex++;
        }
    }

    Artwork {
        id: artwork
        anchors.fill: parent
    }

    Slider {
        id: slider
        height: 50

        slides: [
            Slide {
                title: qsTr("Hello")
                body: qsTr("Manjaro is simple and elegant yet fully customizable. Use as is or create something incredible? You decide.")
                footer: qsTr("During the installation, this slideshow will provide a quick introduction.")
            },
            Slide {
                title: qsTr("Pamac")
                secondaryTitle: qsTr("Add/Remove Software")
                body: qsTr("Accessible via command line or fast, beautiful graphical interface. Add or remove software with the greatest of ease.")
            },
            Slide {
                title: qsTr("Control Panel")
                body: qsTr("Settings manager, the same for every redaction you choose, will help you to install drivers, download missing translation and language packets, or update your kernel.")
            },
            Slide {
                title: qsTr("Thank You")
                body: qsTr("It's time to relax and prepare for new adventures.")
                footer: qsTr("Check our forum and wiki if you have any questions or feedback.")
            }

        ]
        anchors {
            centerIn: parent
            horizontalCenterOffset: -100
            verticalCenterOffset: -57
        }
    }

}

