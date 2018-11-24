import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import QtGraphicalEffects 1.0
import Ubuntu.Components.Popups 1.3
import "../components"

ListItem {
    id: noteListItem

    height: layout.height

    visible: { searching ? layout.title.text.toUpperCase().indexOf( searchField.displayText.toUpperCase() ) !== -1 : true }

    property var noteID: id

    onClicked: {
        if ( mainStack.depth > 1 ) mainStack.pop()
        activeNote = noteID
        mainStack.push(Qt.resolvedUrl("../pages/EditPage.qml"))
    }

    ListItemLayout {
        id: layout
        width: parent.width
        title.text: text
        subtitle.text: new Date(timestamp).toLocaleString(Qt.locale(), Locale.ShortFormat)
    }

    // Delete Button
    leadingActions: ListItemActions {
        actions: [
        Action {
            iconName: "edit-delete"
            onTriggered: {
                db.transaction(
                    function(tx) {
                        var res = tx.executeSql("DELETE FROM Notes WHERE id=" + id)
                        dashPage.update ()
                    }
                )
            }
        }
        ]
    }
}
