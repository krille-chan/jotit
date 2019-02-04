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

    property var searching: false

    header: DefaultHeader {
        id: header
        title: i18n.tr('Jotit')
        sideStack: true

        trailingActionBar {
            actions: [
            Action {
                iconName: searching ? "close" : "search"
                onTriggered: DashActions.toggleSearch ()
            },
            Action {
                iconName: "info"
                onTriggered: layout.pushPage( "Info" )
            },
            Action {
                iconName: "add"
                onTriggered: DashActions.create ()
            }
            ]
        }
    }

    Label {
        text: i18n.tr("You have no notes yet")
        anchors.centerIn: parent
        visible: noteListView.count === 0
    }


    TextField {
        id: searchField
        objectName: "searchField"
        visible: searching
        z: 5
        anchors {
            top: header.bottom
            topMargin: units.gu(1)
            bottomMargin: units.gu(1)
            left: parent.left
            right: parent.right
            rightMargin: units.gu(2)
            leftMargin: units.gu(2)
        }
        inputMethodHints: Qt.ImhNoPredictiveText
        placeholderText: i18n.tr("Search…")
        onDisplayTextChanged: notesModel.search ( displayText )
    }


    ListView {
        id: noteListView
        width: parent.width
        height: parent.height - header.height
        anchors.top: header.bottom
        anchors.topMargin: searching * (searchField.height + units.gu(2))
        delegate: NoteListItem {}
        model: notesModel
        add: Transition {
            NumberAnimation { property: "opacity"; to: 100; duration: 300 }
        }
        remove: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; to: 0; duration: 300 }
            }
        }
        move: Transition {
            SmoothedAnimation { property: "y"; duration: 300 }
        }
        displaced: Transition {
            SmoothedAnimation { property: "y"; duration: 300 }
        }
    }
}
