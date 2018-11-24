import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import "../components"


Page {
    anchors.fill: parent
    id: page

    header: DefaultHeader {
        id: header
    }

    RoundedImage {
        anchors.centerIn: parent
        width: parent.width / 3
        height: width
        source: "../../assets/logo.png"
    }

}
