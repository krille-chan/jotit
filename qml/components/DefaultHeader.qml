import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

PageHeader {
    id: header

    property var sideStack: false

    StyleHints {
        foregroundColor: "#3b88c4"
    }

    leadingActionBar {
        actions: [
        Action {
            visible: !sideStack && mainStack.depth > 1
            iconName: "go-previous"
            onTriggered: mainStack.pop()
        }
        ]
    }
}
