import io.calamares.ui 1.0
import io.calamares.core 1.0

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

Rectangle {
    id: sideBar;

    SystemPalette {
        id: systemPalette
    }

    color: systemPalette.window;

    antialiasing: true

    Rectangle {
        anchors.fill: parent
        anchors.rightMargin: 35/2
        color: Branding.styleString(Branding.SidebarBackground)
    }

    ListView {
        id: list
        anchors.leftMargin: 12
        anchors.fill: parent
        model: ViewManager
        interactive: false
        spacing: 0
        delegate: RowLayout {
            visible: index!=0
            height: index==0?0:50
            width: parent.width

            Text {
                Layout.fillWidth: true
                fontSizeMode: Text.Fit
                color: Branding.styleString(Branding.SidebarText)
                text: display;
                font.pointSize : 12
                minimumPointSize: 5
                Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                clip: true
            }
            Item {
                Layout.fillHeight: true
                Layout.preferredWidth: 35

                Rectangle {
                    anchors.centerIn: parent
                    id: image
                    height: parent.width*0.65
                    width: height
                    radius: height/2
                    color: {
                        if (index>ViewManager.currentStepIndex) {
                            return systemPalette.mid;
                        }
                        return systemPalette.highlight
                    }
                    z: 10
                }
                Rectangle {
                    color: {
                        if (index>ViewManager.currentStepIndex && index!=1) {
                            return systemPalette.mid;
                        }
                        return systemPalette.highlight;

                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: image.verticalCenter
                    height: parent.height/2
                    width: 5
                    z: 0
                }
                Rectangle {
                    color: {
                        if (index<ViewManager.currentStepIndex || ViewManager.currentStepIndex==list.count-1) {
                            return systemPalette.highlight;
                        }
                        return systemPalette.mid;
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: image.verticalCenter
                    height: parent.height/2
                    width: 5
                    //visible: (index !== (list.count - 1))
                    z: 0
                }
                Shape {
                    visible: index == ViewManager.currentStepIndex
                    id: shape
                    anchors.fill: parent
                    smooth: true
                    layer.enabled: true
                    layer.samples: 8

                    ShapePath {
                        fillColor: "transparent"
                        strokeColor: systemPalette.highlight
                        strokeWidth: 3
                        capStyle: ShapePath.FlatCap

                        PathAngleArc {
                            centerX: shape.width/2; centerY: shape.height/2
                            radiusX: 15; radiusY: 15
                            startAngle: 0
                            sweepAngle: 360
                        }
                    }
                }
            }
        }
        header: RowLayout {
            height: 55
            anchors.right: parent.right
            anchors.left: parent.left
            Item {
                Layout.fillWidth: true
            }
            Shape {
                id: manjaroShape
                Layout.preferredHeight: 27
                Layout.preferredWidth: 27

                ShapePath {
                    scale: Qt.size((manjaroShape.width-1)/200, (manjaroShape.height-1)/200)

                    fillColor: systemPalette.highlight
                    strokeWidth: -1
                    PathSvg {
                        path: "M 14.28571,0 C 6.37556,0 0,6.375557 0,14.285714 V 185.71428 C 0,193.62444 6.37556,200 14.28571,200 H 57.14286 V 57.142856 h 71.42857 V 0 Z m 128.57144,0 v 200 h 42.85714 C 193.62445,200 200,193.62444 200,185.71428 V 14.285714 C 200,6.375557 193.62445,0 185.71429,0 Z M 71.42857,71.42857 V 200 h 57.14286 V 71.42857 Z m 0,0"
                    }
                }
            }

            Label {
                text: "manjaro"
                font.pointSize: 16
                font.family: "Comfortaa"
                color: Branding.styleString(Branding.SidebarText)
                Layout.fillWidth: true
            }
            Item {
                Layout.fillHeight: true
                Layout.preferredWidth: 35

                Rectangle {
                    color: systemPalette.highlight
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    height: parent.height
                    width: 5
                    z: 0
                }
            }
        }
    }
    Item {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: list.height - list.contentHeight
        width: 35
        Rectangle {
            color: {
                if (ViewManager.currentStepIndex==list.count-1) {
                    return systemPalette.highlight;
                }
                return systemPalette.mid;
            }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            height: parent.height
            width: 5
            z: 0
        }
    }
}
