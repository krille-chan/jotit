import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

ListItem {
    property var name: ""
    property var icon: "settings"
    property var iconColor: UbuntuColors.slate
    color: theme.palette.normal.background
    height: layout.height

    ListItemLayout {
        id: layout
        title.text: name
        Icon {
            name: icon
            color: iconColor
            width: units.gu(4)
            height: units.gu(4)
            SlotsLayout.position: SlotsLayout.Leading
        }
    }
}
