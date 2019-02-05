// File: DefaultLayoutActions.js
// Description: Actions for DefaultLayout.qml

function init () {
    sideStack.push( Qt.resolvedUrl("../pages/DashPage.qml") )
    if ( tabletMode ) mainStack.push( Qt.resolvedUrl("../pages/BlankPage.qml") )
    else mainStack.push( Qt.resolvedUrl("../pages/DashPage.qml") )
}

function onTabledModeChanged () {
    if ( prevMode !== tabletMode ) {
        mainStack.clear ()
        if ( tabletMode ) mainStack.push( Qt.resolvedUrl("../pages/BlankPage.qml") )
        else mainStack.push( Qt.resolvedUrl("../pages/DashPage.qml") )
        prevMode = tabletMode
    }
}

function getPath ( page ) {
    return "../pages/%1Page.qml".arg( page )
}

function pushPage ( page ) {
    apLayout.addPageToNextColumn( dashPage, Qt.resolvedUrl ( getPath( page ) ) )
}

function openNote ( id ) {
    notesModel.currentNodeId = id
    apLayout.addPageToNextColumn( dashPage, Qt.resolvedUrl ( getPath( "Edit" ) ), { "noteID": id } )
}
