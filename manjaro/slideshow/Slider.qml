import QtQuick 2.15

Item {
    property list<Slide> slides

    property int currentSlideIndex: 0
    property int _currentSlideIndex: 0
    property int slidesSize: slides.length
    property bool firstIteration: true

    function reset() {
        currentSlideIndex = 0;
        firstIteration = true;
    }

    onCurrentSlideIndexChanged: {
        if (currentSlideIndex >= slidesSize) {
            firstIteration = false;
            currentSlideIndex = 0;
        }

        transitionAnimation.start();
    }

    Column {
        anchors.fill: parent
        spacing: 10

        Text {
            id: titleText
            font {
                family: "Comfortaa"
                capitalization: Font.AllLowercase
                weight: Font.DemiBold
                pointSize: 18
            }
            color: "white"
            text: slides[_currentSlideIndex].title
        }
        Text {
            id: bodyText
            font {
                family: "Comfortaa"
                pointSize: 12
            }
            width: 400
            color: "white"
            text: slides[_currentSlideIndex].body
            wrapMode: Text.Wrap
        }

        Text {
            id: footerText
            font {
                family: "Comfortaa"
                weight: Font.Light
                pointSize: 12
            }
            width: 400
            color: "white"
            text: slides[_currentSlideIndex].footer ?? ""
            wrapMode: Text.Wrap
        }
    }

    SequentialAnimation {
        id: transitionAnimation
        property int duration: 700

        ParallelAnimation {
            OpacityAnimator {
                target: titleText
                from: 1.0
                to: 0.0
                duration: transitionAnimation.duration
            }
            OpacityAnimator {
                target: bodyText
                from: 1.0
                to: 0.0
                duration: transitionAnimation.duration
            }
            OpacityAnimator {
                target: footerText
                from: 1.0
                to: 0.0
                duration: transitionAnimation.duration
            }
            XAnimator {
                target: titleText
                from: 0
                to: -30
                duration: transitionAnimation.duration
            }
            XAnimator {
                target: bodyText
                from: 0
                to: -25
                duration: transitionAnimation.duration
            }
            XAnimator {
                target: footerText
                from: 0
                to: -25
                duration: transitionAnimation.duration
            }
        }

        ScriptAction {
            script: _currentSlideIndex = currentSlideIndex
        }

        ParallelAnimation {
            OpacityAnimator {
                target: titleText
                from: 0.0
                to: 1.0
                duration: transitionAnimation.duration
            }
            OpacityAnimator {
                target: bodyText
                from: 0.0
                to: 1.0
                duration: transitionAnimation.duration
            }
            OpacityAnimator {
                target: footerText
                from: 0.0
                to: 1.0
                duration: transitionAnimation.duration
            }
            XAnimator {
                target: titleText
                from: 30
                to: 0
                duration: transitionAnimation.duration
            }
            XAnimator {
                target: bodyText
                from: 25
                to: 0
                duration: transitionAnimation.duration
            }
            XAnimator {
                target: footerText
                from: 25
                to: 0
                duration: transitionAnimation.duration
            }
        }
    }
}
