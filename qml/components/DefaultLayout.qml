import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import "../pages"
import "../scripts/DefaultLayoutActions.js" as DefaultLayoutActions

AdaptivePageLayout {
    id: apLayout

    anchors.fill: parent

    primaryPageSource: DashPage { id: dashPage }

    signal openNote ( var id )
    signal pushPage ( var page )
    onOpenNote: DefaultLayoutActions.openNote ( id )
    onPushPage: DefaultLayoutActions.pushPage ( page )

}
