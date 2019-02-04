// File: StorageActions.js
// Description: Actions to inlcude in other scripts. Needs including:
// .import QtQuick.LocalStorage 2.0 as Database
// to work!
var db = Database.LocalStorage.openDatabaseSync("JotitDB", "1.0", "The database of the app Jotit", 1000000)

function transaction ( query, values, callback ) {
    db.transaction(
        function(tx) {
            try {
                if ( values === undefined ) values = []
                var result = tx.executeSql( query, values )
                if ( callback ) callback ( result )
            }
            catch ( e ) {
                console.warn( "[DATABASE ERROR]", e )
            }
        }
    )
}
