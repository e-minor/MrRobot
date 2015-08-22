import QtQuick 2.0
import Ubuntu.Components 1.1
import QtSensors 5.0
import QtMultimedia 5.0
import MrRobot 1.0

/*!
    \brief MainView of MsRobot
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "mrrobot.e"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(75)

    transformOrigin: Item.Center
    clip: false
    opacity: 1

    Page {
        clip: false

        AudioRecorder {
            id: audio
            name: "sample.wav"

            onRecordingChanged: {
                console.debug("recording: " + recording);
            }
        }

        MediaPlayer {
            id: player
            autoPlay: true
            volume: 1.0
        }

        Image {
            id: base_image
            anchors.bottom: parent.bottom
            width: parent.width
            height: parent.height / 4

            source: "background.png"
        }

        Image {
            anchors.top: parent.top
            anchors.bottom: base_image.top
            width: parent.width

            source: "background_orange.png"
        }



        Image {
            id: robot_image
            anchors.top: parent.top
            anchors.bottom: base_image.top
            anchors.topMargin: units.gu(4)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: units.gu(2)
            width: parent.width
            fillMode: Image.PreserveAspectFit
            source: "robot.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.debug("touch")
                    label.text = "robot action"

                    player.source = audio.path();
                    player.play();
                }
            }


            // body
            MouseArea {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: parent.height / 2
                onClicked: {
                    console.debug("touch")
                    label.text = "body action"
                    parent.source = "robot.png"
                }
            }

            // right hand
            MouseArea {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: parent.width / 5
                height: parent.height / 2
                onClicked: {
                    console.debug("touch")
                    label.text = "right hand action"
                    parent.source = "robot_right.png"
                }
            }

            // left hand
            MouseArea {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                width: parent.width / 5
                height: parent.height / 2
                onClicked: {
                    console.debug("touch")
                    label.text = "left hand action"
                    parent.source = "robot_left.png"
                }
            }
        }

        Image {
            id: eye_image
            anchors.top: parent.top
            anchors.topMargin: units.gu(4)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: units.gu(2)
            width: parent.width
            fillMode: Image.PreserveAspectFit
            source: "eye_blue.png"

            MouseArea {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width / 2
                height: parent.height / 3
                onClicked: {
                    console.debug("touch")
                    var image_name = parent.source.toString()
                    label.text = image_name.substring(40)
                    if (image_name.search("eye_blue.png") > 0) {
                        parent.source = "eye_green.png"
                    } else if (image_name.search("eye_green.png") > 0) {
                        parent.source = "eye_orange.png"
                    } else {
                        parent.source = "eye_blue.png"
                    }
                }
            }
        }

        Label {
            id: label
            objectName: "label"

            text: "hello, world"
        }


        Image {
            id: voice_image
            anchors.bottom: base_image.bottom
            anchors.top: base_image.top
            anchors.margins: units.gu(2)
            anchors.horizontalCenter: parent.horizontalCenter
            width: base_image.width
            fillMode: Image.PreserveAspectFit
            source: "voice.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (audio.recording) {
                        console.debug("stop recording")
                        label.text = "stop recording"

                        voice_image.source = "voice.png"
                        audio.stop()
                    } else {
                        console.debug("recording")
                        label.text = "recording"

                        voice_image.source = "voice_active.png"
                        audio.record()
                    }
                }
            }
        }



        SensorGesture{
            gestures : ["QtSensors.shake", "QtSensors.pickup", "QtSensors.twist", "QtSensors.slam"]
            enabled: true
            onDetected:{
                console.debug(gesture)
                label.text = 'gesture - ' + gesture
            }
        }

    }
}

