import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Content 1.3
import "../components"

Page {
    anchors.fill: parent
    id: dashPage
    property var timestamp
    property var displayTime: new Date(timestamp).toLocaleString(Qt.locale(), Locale.ShortFormat)
    property var savedText: ""
    property var noteID

    Component.onCompleted: {
        noteID = activeNote
        db.transaction(
            function(tx) {
                var res = tx.executeSql("SELECT * FROM Notes WHERE id=" + noteID)
                timestamp = res.rows[0].timestamp
                textArea.text = savedText = res.rows[0].text || ""

                if ( textArea.text === "" ) textArea.focus = true
            }
        )
    }

    Component.onDestruction: {
        if ( textArea.displayText === "" ) {
            db.transaction(
                function(tx) {
                    tx.executeSql("DELETE FROM Notes WHERE id=" + noteID + " ")
                    updateGUI()
                }
            )
        }
        noteID = ""
    }


    header: DefaultHeader {
        id: header
        title: i18n.tr('Last updated: %1').arg(displayTime)
        trailingActionBar {
            actions: [
            Action {
                iconName: "share"
                onTriggered: share.share ( textArea.displayText, textArea.displayText )
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
            topMargin: -units.gu(0.3)
        }
        onDisplayTextChanged: {
            if ( displayText !== savedText ) {
                db.transaction(
                    function(tx) {
                        timestamp = new Date().getTime()
                        tx.executeSql("UPDATE Notes SET timestamp=" + timestamp + ", text='" + textArea.displayText + "' WHERE id=" + noteID)
                        savedText = textArea.displayText
                    }
                )
            }
        }
    }
}
