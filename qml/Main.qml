import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Suru 2.2
import QtQuick.LocalStorage 2.0
import "components"
import "controller"

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'jotit.christianpauly'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    // automatically anchor items to keyboard that are anchored to the bottom
    anchorToKeyboard: true

    readonly property var version: "1.3.1"
    property var tabletMode: width > units.gu(90)
    property var prevMode: false
    property var activeNote: ""

    signal updateGUI ()

    ShareController { id: share }

    onTabletModeChanged: {
        if ( prevMode !== tabletMode ) {
            mainStack.clear ()
            if ( tabletMode ) mainStack.push( Qt.resolvedUrl("./pages/BlankPage.qml") )
            else mainStack.push( Qt.resolvedUrl("./pages/DashPage.qml") )
            prevMode = tabletMode
        }
    }

    property var db: LocalStorage.openDatabaseSync("JotitDB", "1.0", "The database of the app Jotit", 1000000)

    StackView {
        id: sideStack
        visible: tabletMode
        anchors.left: parent.left
        anchors.top: parent.top
        width: tabletMode ? units.gu(45) : parent.width
        height: parent.height
        z: 10
    }

    Rectangle {
        anchors.fill: sideStack
        z: 9
        color: "white"
        visible: tabletMode
    }

    Rectangle {
        height: parent.height
        visible: tabletMode
        width: units.gu(0.1)
        color: UbuntuColors.slate
        anchors.top: parent.top
        anchors.left: sideStack.right
        z: 11
    }

    StackView {
        id: mainStack
        anchors.fill: undefined
        anchors.right: parent.right
        anchors.top: parent.top
        width: tabletMode ? parent.width - units.gu(45) : parent.width
        height: parent.height
    }


    Component.onCompleted: {
        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS Notes( id INTEGER, text TEXT, timestamp INTEGER, UNIQUE (id) )')
            })
            sideStack.push( Qt.resolvedUrl("./pages/DashPage.qml") )
            if ( tabletMode ) mainStack.push( Qt.resolvedUrl("./pages/BlankPage.qml") )
            else mainStack.push( Qt.resolvedUrl("./pages/DashPage.qml") )

        }
    }
