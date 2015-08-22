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
            width: parent.width
            height: parent.height

            source: "background.png"
        }

        Column {
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            Image {
                width: parent.width
                anchors.margins: units.gu(8)
                anchors.topMargin: units.gu(32)
                fillMode: PreserveAspectFit
                source: "robot.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.debug("touch")
                        label.text = "touch action"

                        player.source = audio.path();
                        player.play();
                    }
                }
            }



            Label {
                id: label
                objectName: "label"

                text: "hello, world"
            }

            Item {
                width: parent.height / 6
                height: parent.height / 6
                anchors.bottom: parent.bottom
                anchors.bottomMargin: units.gu(1)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: units.gu(2)

                Image {
                    id: voicecontrol
                    width: parent.height
                    height: parent.height
                    //anchors.topMargin: units.gu(2)
                    fillMode: PreserveAspectFit
                    source: "voice.png"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (audio.recording) {
                                console.debug("stop recording")
                                label.text = "stop recording"

                                voicecontrol.source = "voice.png"
                                audio.stop()
                            } else {
                                console.debug("recording")
                                label.text = "recording"

                                voicecontrol.source = "voice_active.png"
                                audio.record()
                            }
                        }
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

