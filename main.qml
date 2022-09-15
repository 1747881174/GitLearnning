import QtQuick 2.0
import QtQuick.Window
import QtQuick.Controls
//import QtQuick.Controls.Styles
import QtQuick.Dialogs


Window {
    width: 640
    height: 480
    visible: true
    minimumHeight: 380
    minimumWidth: 480
    title: qsTr("Hello World")

    BusyIndicator{
        id: busy
        running: false
        anchors.centerIn: parent
        z: 2
    }

    Text{
        id: stateLable
        visible: false
        anchors.centerIn: parent
        z :3
    }

    Image{
        id: imageViewer
        asynchronous: true
        cache: false
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        onStatusChanged: {
            if(imageViewer.status === Image.Loading){
                busy.running = true;
                stateLable.visible = false;
            }
            else if(imageViewer.status === Image.Ready){
                busy.running = false;
                stateLable.visible = false;
            }
            else if(imageViewer.status === Image.Error){
                busy.running = true;
                stateLable.visible = true;
                stateLable.text = "ERROE"
            }
        }
    }

    Button{
        id: openFile
        text:"Open"
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        style: ButtonStyle{
            background: Rectangle{
                implicitWidth: 70
                implicitHeight: 25
                color: Control.hovered ? "#0c0c0c" : "#a0a0a0"
                border.width: Control.pressed ? 2 : 1
                border.color: Control.hovered || Control.pressed ? "green" : "#888888"
            }
        }
        onClicked: fileDialog.open()
        z: 4
    }

    Text{
        id: imagePath
        anchors.left: openFile.right
        anchors.leftMargin: 8
        anchors.verticalCenter: openFile.verticalCenter
        font.pixelSize: 18
    }

    FileDialog{
        id: fileDialog
        title: "Please choose a file"
        nameFilters:["Image Files (*.jpg *.png *.gif)"]
        onAccepted:{
            imageViewer.source = fileDialog.fileUrl;
            var imageFile = new String(fileDialog.fileUrl);
            imagePath.text = imageFile.slice(8);
        }
    }
}
