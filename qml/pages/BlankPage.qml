import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {
    anchors.fill: parent
    id: page

    Image {
        anchors.centerIn: parent
        width: parent.width / 3
        height: width
        source: "../../assets/logo.png"
    }

}
