import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Ubuntu.Content 1.3
import Qt.labs.settings 1.0
import "components"
import "models"
import "scripts/MainActions.js" as MainActions

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'jotit.christianpauly'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Settings {
        property alias width: root.width
        property alias height: root.height
    }

    // automatically anchor items to keyboard that are anchored to the bottom
    anchorToKeyboard: true

    DefaultLayout { id: layout }

    NotesModel { id: notesModel }

    ContentHubModel {
        id: contentHub
        onShareRequested: MainActions.startImport(transfer)
    }
}
