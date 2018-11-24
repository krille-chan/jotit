import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import QtGraphicalEffects 1.0

Rectangle {
    property alias source: image.source
    radius: width / 6
    color: "white"
    border.width: 1
    border.color: UbuntuColors.silk
    z:1
    clip: true
    Rectangle {
        id: mask
        anchors.fill: parent
        radius: parent.radius
        visible: false
    }
    Image {
        id: image
        anchors.fill: parent
        sourceSize.width: width
        sourceSize.height: height
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
    }
}
