import QtQuick 2.4
import QtQuick.LocalStorage 2.0 as Database
import "../scripts/StorageActions.js" as StorageActions

ListModel {
    id: model

    function add ( text ) {
        var now = new Date().getTime()
        StorageActions.transaction('INSERT INTO Notes VALUES(?, ?, ?)', [
        now,
        text,
        now
        ])
        model.append ( {
            "id": now,
            "text": text,
            "timestamp": now,
            "isVisible": true
        } )
        return now
    }


    function update ( id, text ) {
        var now = new Date().getTime()
        StorageActions.transaction ( 'UPDATE Notes SET text=?, timestamp=? WHERE id=?', [
        text,
        now,
        id
        ] )
        var n = getViewIDByID ( id )
        model.set ( n, { "text": text, "timestamp": now })

        var oldN = n
        // Reorder the list
        while ( n > 0 && model.get( n ).timestamp > model.get( n-1 ).timestamp ) n--
        model.move( oldN, n, 1 )
    }


    function clear ( id ) {
        StorageActions.transaction ( 'DELETE FROM Notes WHERE id=?', [ id ] )
        model.remove ( getViewIDByID ( id ) )
    }


    function getViewIDByID ( id ) {
        for ( var i = 0; i < model.count; i++ ) {
            if ( model.get(i).id === id ) return i
        }
    }


    function getNote ( id, callback ) {
        var handleResult = function ( result ) {
            if ( result.rows.length !== 1 ) callback ( false )
            else callback ( result.rows[0] )
        }

        StorageActions.transaction ( 'SELECT text, timestamp FROM Notes WHERE id=?', [ id ], handleResult )
    }


    function search ( str ) {
        var searchStr = str.toUpperCase()
        for ( var i = 0; i < model.count; i++ ) {
            var visible = model.get(i).text.toUpperCase().indexOf( searchStr ) !== -1
            model.set( i, { "isVisible": visible })
        }
    }


    function _init() {

        var updateList = function ( rs ) {
            model.clear()
            for (var i = 0; i < rs.rows.length; i++) {
                var item = rs.rows.item(i)
                item.isVisible = true
                model.append ( item )
            }
        }

        StorageActions.transaction ( 'CREATE TABLE IF NOT EXISTS Notes( id INTEGER, text TEXT, timestamp INTEGER, UNIQUE (id) )' )
        StorageActions.transaction ( 'SELECT * FROM Notes ORDER BY timestamp DESC', [], updateList )
    }

    Component.onCompleted: _init ()
}
