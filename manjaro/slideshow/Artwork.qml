import QtQuick 2.15

Rectangle {
    id: root

    // Max size of the scene - needed to load heavy assets only once and also set star field sizes
    QtObject {
        id: maxSceneSize
        property int width: 6075
        property int height: 6950
    }


    SystemPalette {
        id: systemPalette
    }

    color: "#103e49"

    Image {
        id: comet
        source: "comet.svg"
        sourceSize {
            width: 50
            height: 50
        }
        opacity: 0

        Timer {
            id: cometShowupTimeout
            running: true
            interval: 6000
            repeat: true
            onTriggered: {
                comet.x = Math.floor(Math.random() * root.width);
                comet.y = Math.floor(Math.random() * root.height);
                cometShowupAnimation.start();
            }
        }

        ParallelAnimation {
            id: cometShowupAnimation
            loops: 1

            SequentialAnimation {
                NumberAnimation {
                    target: comet
                    property: "opacity"
                    duration: 200
                    from: 0
                    to: 1
                }
                NumberAnimation {
                    target: comet
                    property: "opacity"
                    duration: 200
                    from: 1
                    to: 0
                }
            }
            NumberAnimation {
                target: comet
                properties: "x"
                duration: 700
                easing.type: Easing.OutQuad
                to: comet.x-100
            }
            NumberAnimation {
                target: comet
                properties: "y"
                duration: 700
                easing.type: Easing.OutQuad
                to: comet.y+100
            }
        }
    }

    Column {
        id: starsClose

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            topMargin: -starsClose1.sourceSize.height
        }
        height: starsClose1.sourceSize.height+starsClose2.sourceSize.height

        Image {
            id: starsClose1
            source: 'starsClose.svg'

            sourceSize {
                height: maxSceneSize.height
                width: maxSceneSize.width
            }
        }
        Image {
            id: starsClose2
            source: 'starsClose.svg'

            sourceSize {
                height: maxSceneSize.height
                width: maxSceneSize.width
            }
        }
        NumberAnimation {
            id: starsCloseMovingAnimation
            running: true
            loops: -1

            duration: 100000
            target: starsClose
            property: "anchors.topMargin"
            from: -starsClose1.sourceSize.height
            to: 0
        }
    }

    Column {
        id: starsFar

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            topMargin: -starsFar1.sourceSize.height
        }
        height: starsFar1.sourceSize.height+starsFar2.sourceSize.height

        Image {
            id: starsFar1
            source: 'starsFar.svg'

            sourceSize {
                height: maxSceneSize.height
                width: maxSceneSize.width
            }
        }
        Image {
            id: starsFar2
            source: 'starsFar.svg'

            sourceSize {
                height: maxSceneSize.height
                width: maxSceneSize.width
            }
        }

        NumberAnimation {
            id: starsFarMovingAnimation
            running: true
            loops: -1
            duration: 200000
            target: starsFar
            property: "anchors.topMargin"
            from: -starsFar1.sourceSize.height
            to: 0
        }
    }

    Image {
        id: moon
        source: "moon.svg"
        sourceSize.height: height
        sourceSize.width: width
        x: -height
        height: 70
        width: height

        Timer {
            id: moonShowupTimeout
            running: true
            interval: 25000
            repeat: true
            onTriggered: {
                moon.height = Math.floor(Math.random() * (45 - 200) + 200)

                moon.x = Math.floor(Math.random() * root.width);
                moonShowupAnimation.start();
            }
        }
        NumberAnimation {
            id: moonShowupAnimation
            target: moon
            properties: "y"
            duration: 25000
            from: -moon.height
            to: maxSceneSize.height+moon.height
        }

    }

    Image {
        id: background
        anchors.fill: parent

        mipmap: true
        source: systemPalette.window.hslLightness > 0.5 ? "background.svg" : "background_dark.svg"

        sourceSize {
            height: maxSceneSize.height
            width: maxSceneSize.width
        }
    }

    Item {
        id: smoke

        anchors{
            bottom: parent.bottom
            right: parent.right
            left: parent.left
        }
        height: smokeAsset.paintedHeight

        Rectangle {
            anchors{
                bottom: parent.bottom
                right: parent.right
                left: parent.left
            }
            height: 57

            color: "#eff0f1"
        }
        Image {
            id: smokeAsset
            anchors{
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
            source: "smoke.svg"
            sourceSize.width: width
            sourceSize.height: height
        }
    }

    Rocket {
        id: rocket
        property int lift: 0

        anchors {
            bottom: parent.bottom
            bottomMargin: -(height-lift)
            horizontalCenter: parent.horizontalCenter
            horizontalCenterOffset: -235
        }
        width: 100
        showSmoke: true
    }

    state: "onGround"

    states: [
        State {
            name: "onGround"
            PropertyChanges {
                target: rocket
                lift: 180
            }
            PropertyChanges {
                target: background
                anchors.topMargin: -root.height
                anchors.bottomMargin: 20
                opacity: 1
            }
            PropertyChanges {
                target: starsCloseMovingAnimation
                running: false
            }
            PropertyChanges {
                target: starsFarMovingAnimation
                running: false
            }
            PropertyChanges {
                target: moonShowupTimeout
                running: false
            }
            PropertyChanges {
                target: cometShowupTimeout
                running: false
            }
        },
        State {
            extend: "onGround"
            name: "nearGround"
            PropertyChanges {
                target: rocket
                lift: root.height/2 + 150
            }
            PropertyChanges {
                target: smoke
                anchors.bottomMargin: -smoke.height/2 + 100
            }

            PropertyChanges {
                target: background
                anchors.bottomMargin: -(root.height*0.2)
                anchors.topMargin: -root.height+root.height*0.2
            }
        },
        State {
            extend: "nearGround"
            name: "inAtmosphere"
            PropertyChanges {
                target: rocket
                showSmoke: false
            }
            PropertyChanges {
                target: rocket
                lift: root.height/2 + 100
            }
            PropertyChanges {
                target: background
                anchors.bottomMargin: -root.height*0.9
                anchors.topMargin: 0
            }
        },
        State {
            extend: "inAtmosphere"
            name:  "inSpace"
            PropertyChanges {
                target: background
                anchors.bottomMargin: -(root.height*2)
                anchors.topMargin: root.height
            }
            PropertyChanges {
                target: starsCloseMovingAnimation
                running: true
            }
            PropertyChanges {
                target: starsFarMovingAnimation
                running: true
            }
            PropertyChanges {
                target: moonShowupTimeout
                running: true
            }
            PropertyChanges {
                target: cometShowupTimeout
                running: true
            }
        }
    ]

    transitions: [
        Transition{
            id: transition1
            from: "onGround"
            to: "nearGround"
            SequentialAnimation {
                NumberAnimation {
                    target: rocket
                    property: "lift"
                    duration: 10000
                    easing.type: Easing.InQuad
                }
                ScriptAction { script: root.state = "inAtmosphere" }
            }
            NumberAnimation {
                target: smoke
                property: "bottomMargin"
                duration: 10000
                easing.type: Easing.InQuad

            }
            NumberAnimation {
                target: background
                properties: "anchors.topMargin,anchors.bottomMargin"
                duration: 10000
                easing.type: Easing.InQuad
            }
        },
        Transition {
            id: transition2
            from: "nearGround"
            to: "inAtmosphere"
            NumberAnimation {
                target: rocket
                property: "lift"
                duration: 5000
                easing.type: Easing.OutQuad
            }
            SequentialAnimation {
                NumberAnimation {
                    target: background
                    properties: "anchors.topMargin,anchors.bottomMargin"
                    duration: 5000
                }
                ScriptAction { script: root.state = "inSpace" }
            }
        },
        Transition {
            id: transition3
            from: "inAtmosphere"
            to: "inSpace"
            NumberAnimation {
                target: rocket
                property: "lift"
                duration: 3000
                easing.type: Easing.OutQuad
            }

            NumberAnimation {
                target: background
                properties: "anchors.bottomMargin"
                duration: 15000
                from: -root.height
            }
            NumberAnimation {
                target: background
                properties: "anchors.topMargin"
                duration: 15000
                from: 0
            }
        }
    ]

    // Animation objects don't bind properties - so we have to reset the animation when a window size changes. In our case it's only about height.
    // Timeout is needed to ensure that properties already have needed values set.
    Timer {
        id: sizeChangeTimeout
        interval: 1

        onTriggered: {
            switch(state) {
            case "nearGround":
                if(!transition1.running) return;
                state = "onGround";
                state = "nearGround";
                break;
            case "inAtmosphere":
                if(!transition2.running) return;
                state = "nearGround";
                state = "inAtmosphere";
                break;
            case "inSpace":
                if(!transition3.running) return;
                state = "inAtmosphere";
                state = "inSpace";
            }
        }
    }

    onHeightChanged: {
        sizeChangeTimeout.restart();
    }

}
