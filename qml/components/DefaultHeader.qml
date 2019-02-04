import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import "../config.js" as Config

PageHeader {
    id: header

    property var sideStack: false

    StyleHints {
        foregroundColor: Config.headerFontColor
    }
}
