// File: LayoutActions.js
// Description: Actions for all Qml Pages and Components
Qt.include("LayoutActions.js")

function create () {
    openNote ( notesModel.add ( "" ) )
}

function toggleSearch () {
    searching = searchField.focus = !searching
    if ( !searching ) searchField.text = ""
}
