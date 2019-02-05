// File: EditActions.js
// Description: Actions for EditPage.qml
Qt.include("TimestampActions.js")
Qt.include("../config.js")

var lastsaved = new Date().getTime() - SAVE_TIMEOUT

function init () {
    textArea.text = ""
    var addToGUI = function ( note ) {
        timestamp = note.timestamp
        if ( note.text && note.text !== "" ) {
            textArea.text = prevText = note.text.split("&#39;").join("'") || ""
        }
        else textArea.focus = true
    }

    notesModel.getNote ( noteID, addToGUI )
}


function autoSave () {
    if ( new Date().getTime () - lastsaved > SAVE_TIMEOUT ) {
        save ()
    }
}

function save () {
    if ( prevText !== textArea.text ) {
        console.log("Saved", lastsaved)
        timestamp = new Date().getTime()
        var input = textArea.displayText.split("'").join("&#39;")
        notesModel.update ( noteID, textArea.displayText )
        lastsaved = new Date().getTime()
    }
}


function share () {
    if ( textArea.displayText !== "" ) {
        shareDialog.share ( textArea.displayText )
    }
}


function undo () {
    textArea.text = prevText
    save ()
}


function exit () {
    if ( textArea.displayText === "" ) {
        notesModel.clear ( noteID )
    }
    else save ()
}


function getDisplayTime () {
    return tsToString ( timestamp )
}
