import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Content 1.3
import "../components"
import "../scripts/EditActions.js" as EditActions
import "../config.js" as Config

Page {
    anchors.fill: parent
    id: editPage

    // The ID of the note which is opened
    property var noteID

    property var timestamp: 0
    property var prevText: ""

    onNoteIDChanged: EditActions.init ()

    Component.onDestruction: EditActions.exit ()


    header: DefaultHeader {
        id: header
        title: i18n.tr('Last updated')

        contents: Column {
            width: parent.width
            anchors.centerIn: parent

            Label {
                text: header.title
                color: Config.headerFontColor
                textSize: Label.Large
            }

            Label {
                height: units.gu(2)
                text: EditActions.getDisplayTime()
                color: Config.headerFontColor
            }
        }

        trailingActionBar {
            actions: [
            Action {
                iconName: "share"
                onTriggered: contentHub.shareText ( textArea.displayText )
                enabled: textArea.displayText !== ""
            },
            Action {
                iconName: "edit-undo"
                onTriggered: textArea.text = prevText
                enabled: EditActions.savedText !== prevText
            }
            ]
        }
    }


    TextArea {
        id: textArea
        anchors {
            top: header.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            margins: -units.gu(0.3)
        }
        onDisplayTextChanged: EditActions.autoSave ()
    }

}
