// File: EditActions.js
// Description: Actions for EditPage.qml
Qt.include("TimestampActions.js")

var savedText = ""

function init () {
    textArea.text = ""
    var addToGUI = function ( note ) {
        timestamp = note.timestamp
        if ( note.text ) {
            textArea.text = savedText = prevText = note.text.split("&#39;").join("'") || ""
        }
        else textArea.focus = true
    }

    notesModel.getNote ( noteID, addToGUI )
}


function autoSave () {
    if ( textArea.displayText !== savedText ) {
        timestamp = new Date().getTime()
        var input = textArea.displayText.split("'").join("&#39;")
        notesModel.update ( noteID, textArea.displayText )
        savedText = textArea.displayText
    }
}


function share () {
    if ( textArea.displayText !== "" ) {
        shareDialog.share ( textArea.displayText )
    }
}


function exit () {
    if ( textArea.displayText === "" ) {
        notesModel.clear ( noteID )
    }
}


function getDisplayTime () {
    return tsToString ( timestamp )
}
