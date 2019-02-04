// File: MainActions.js
// Description: Actions for Main.qml

function startImport ( transfer ) {
    console.log("Start import")
    if ( transfer.contentType === ContentType.Links || transfer.contentType === ContentType.Text ) {

        // Extract the pure text
        var text = ""
        for ( var i = 0; i < transfer.items.length; i++ ) {
            if ( transfer.items[i].text ) text += String(transfer.items[i].text)
            if ( transfer.items[i].url ) text += " " + String(transfer.items[i].url)
            text += "\n"
        }
        console.log("Import", text)

        layout.openNote ( notesModel.add ( text ) )
    }
}
