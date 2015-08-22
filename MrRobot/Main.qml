import QtQuick 2.0
import Ubuntu.Components 1.1
import MrRobot 1.0
import QtSensors 5.0
//import AudioRecorder 1.0

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

    Page {
        title: i18n.tr("MrRobot")
/*
        AudioRecorder {
            id: audio
            name: "sample.wav"

            onRecordingChanged: {
                console.log("recording: " + recording);
            }
        }
*/
        Column {
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            Image {
                width: parent.width
                height: parent.width

                source: "robot.png"

                MouseArea {
                    id: robot
                    anchors.fill: parent
                    onClicked: {
                        console.log("touch")
                        label.text = "touch action"

                        //audio.stop();
                        //player.source = audio.path();
                        //player.play();
                    }
                }
            }

            Label {
                id: label
                objectName: "label"

                text: "hello, world"
            }


            Row {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: units.gu(2)
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.margins: units.gu(2)

                Button {
                    objectName: "button"

                    text: i18n.tr("Voice")

                    onClicked: {
                        console.log("voice action")
                        label.text = "voice action"
                        //audio.record()
                    }
                }
            }
        }

        Accelerometer {
            id: accel
            dataRate: 1000
            active:true

            onReadingChanged: {
                console.log('acc- x: ' + accel.reading.x + ', y: ' + accel.reading.y + ', z: ' + accel.reading.z)
            }
        }
    }
}

