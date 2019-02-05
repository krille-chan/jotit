import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import "../components"
import "../scripts/DashActions.js" as DashActions

Page {
    anchors.fill: parent
    id: dashPage

    property var searching: true

    header: DefaultHeader {
        id: header
        title: i18n.tr('Jotit')
        sideStack: true

        /*leadingActionBar {
            actions: [
            Action {
                iconName: "contextual-menu"
                onTriggered: layout.pushPage ( "Info" )
            }
            ]
        }*/

        trailingActionBar {
            actions: [
            Action {
                iconName: "add"
                onTriggered: DashActions.create ()
            }
            ]
        }

        contents: TextField {
            id: searchField
            objectName: "searchField"
            primaryItem: Icon {
                height: parent.height - units.gu(2)
                name: "find"
                anchors.left: parent.left
                anchors.leftMargin: units.gu(0.25)
            }
            width: parent.width - units.gu(1)
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            inputMethodHints: Qt.ImhNoPredictiveText
            placeholderText: i18n.tr("Search…")
            onDisplayTextChanged: notesModel.search ( displayText )
        }
    }

    Label {
        text: i18n.tr("You have no notes yet")
        anchors.centerIn: parent
        visible: noteListView.count === 0
    }


    ListView {
        id: noteListView
        width: parent.width
        height: parent.height - header.height
        anchors.top: header.bottom
        delegate: NoteListItem {}
        model: notesModel
        move: Transition {
            SmoothedAnimation { property: "y"; duration: 300 }
        }
        displaced: Transition {
            SmoothedAnimation { property: "y"; duration: 300 }
        }
    }
}
