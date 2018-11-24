import QtQuick 2.9
import Ubuntu.Components 1.3
import Ubuntu.Content 1.3
import Ubuntu.Components.Popups 1.3
import "../components"

Item {

    id: shareController

    signal done()

    Connections {
        target: ContentHub
        onShareRequested: startImport(transfer)
    }

    Component {
        id: shareDialog
        ContentShareDialog {
            Component.onDestruction: shareController.done()
        }
    }

    Component {
        id: contentItemComponent
        ContentItem { }
    }


    function startImport ( transfer ) {
        if ( transfer.contentType === ContentType.Links || transfer.contentType === ContentType.Text ) {
            db.transaction(
                function(tx) {
                    var now = new Date().getTime()
                    var text = ""
                    for ( var i = 0; i < transfer.items.length; i++ ) {
                        if ( transfer.items[i].text ) text += String(transfer.items[i].text)
                        if ( transfer.items[i].url ) text += " " + String(transfer.items[i].url)
                        text += "\n"
                    }
                    tx.executeSql("INSERT INTO Notes VALUES(?,?,?)", [
                    now,
                    text,
                    now
                    ])
                    activeNote = now
                    updateGUI()
                    if ( mainStack.depth > 1 ) mainStack.pop()
                    mainStack.push(Qt.resolvedUrl("../pages/EditPage.qml"))
                }
            )
        }
    }

    function share( text ) {
        var sharePopup = PopupUtils.open(shareDialog, shareController, {"contentType" : ContentType.Text})
        sharePopup.items.push(contentItemComponent.createObject(shareController, {"text" : text}))
    }


}
