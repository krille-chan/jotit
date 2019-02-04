import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import QtGraphicalEffects 1.0
import Ubuntu.Components.Popups 1.3
import "../components"
import "../scripts/TimestampActions.js" as TimestampActions

ListItem {
    id: noteListItem

    height: visible*itemLayout.height

    property var noteID: id

    visible: isVisible

    onClicked: layout.openNote ( noteID )

    ListItemLayout {
        id: itemLayout
        width: parent.width
        title.text: text || i18n.tr("Empty...")
        title.color: text === "" ? UbuntuColors.graphite : "black"
        subtitle.text: TimestampActions.tsToString ( timestamp )
    }

    // Delete Button
    leadingActions: ListItemActions {
        actions: [
        Action {
            text: i18n.tr("Delete")
            iconName: "edit-delete"
            onTriggered: notesModel.clear ( noteID )
        }
        ]
    }
}
