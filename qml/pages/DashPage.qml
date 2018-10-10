import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import "../components"

Page {
    anchors.fill: parent
    id: dashPage

    property var searching: false

    Component.onCompleted: update ()

    Connections {
        target: root
        onUpdateGUI: update()
    }

    function update () {
        db.transaction(
            function(tx) {
                var res = tx.executeSql("SELECT * FROM Notes ORDER BY timestamp DESC")
                model.clear ()
                for ( var i = 0; i < res.rows.length; i++ ) {
                    var note = res.rows.item(i)
                    model.append ( {
                        "id": note.id,
                        "text": note.text || i18n.tr('Empty note'),
                        "timestamp": note.timestamp
                    } )
                }
            }
        )
    }


    Connections {
        target: mainStack
        onDepthChanged: {
            searching = false
            update ()
        }
    }


    header: DefaultHeader {
        id: header
        title: i18n.tr('Jotit')
        trailingActionBar {
            actions: [
            Action {
                iconName: searching ? "close" : "search"
                onTriggered: {
                    searching = searchField.focus = !searching
                    if ( !searching ) searchField.text = ""
                }
            },
            Action {
                iconName: "info"
                onTriggered: {
                    if ( mainStack.depth > 1 ) mainStack.pop()
                    mainStack.push(Qt.resolvedUrl("./InfoPage.qml"))
                }
            },
            Action {
                iconName: "add"
                onTriggered: {
                    db.transaction(
                        function(tx) {
                            var now = new Date().getTime()
                            tx.executeSql("INSERT INTO Notes VALUES(?,?,?)", [
                            now,
                            "",
                            now
                            ])
                            if ( mainStack.depth > 1 ) mainStack.pop()
                            activeNote = now
                            mainStack.push(Qt.resolvedUrl("../pages/EditPage.qml"))
                        }
                    )
                    dashPage.update()
                }
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
    }


    ListView {
        id: noteListView
        width: parent.width
        height: parent.height - header.height
        anchors.top: header.bottom
        anchors.topMargin: searching * (searchField.height + units.gu(2))
        delegate: NoteListItem {}
        model: ListModel { id: model }
        add: Transition {
            NumberAnimation { property: "opacity"; to: 100; duration: 300 }
        }
        remove: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; to: 0; duration: 300 }
            }
        }
    }
}
