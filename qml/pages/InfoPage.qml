import QtQuick 2.9
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import "../components"

Page {
    anchors.fill: parent
    id: page

    header: DefaultHeader {
        id: header
        title: i18n.tr('Info about Jotit %1').arg( Qt.application.version )
    }


    ScrollView {
        id: scrollView
        width: parent.width
        height: parent.height - header.height
        anchors.top: header.bottom
        contentItem: Column {
            width: page.width

            UbuntuShape {
                anchors.horizontalCenter: parent.horizontalCenter
                width: Math.min( parent.width/2, units.gu(16) )
                height: width
                relativeRadius: 0.75
                aspect: UbuntuShape.Flat
                source: Image {
                    source: "../../assets/logo.png"
                }
            }

            SettingsListItem {
                name: i18n.tr("Become a patron")
                icon: "like"
                iconColor: UbuntuColors.red
                onClicked: Qt.openUrlExternally("https://www.patreon.com/krillechritzelius")
            }

            SettingsListItem {
                name: i18n.tr("Support on Liberapay")
                icon: "like"
                onClicked: Qt.openUrlExternally("https://liberapay.com/KrilleChritzelius")
            }

            SettingsListItem {
                name: i18n.tr("Contributors")
                icon: "contact-group"
                onClicked: Qt.openUrlExternally("https://github.com/ChristianPauly/jotit/graphs/contributors")
            }

            SettingsListItem {
                name: i18n.tr("Source code")
                icon: "text-xml-symbolic"
                onClicked: Qt.openUrlExternally("https://github.com/ChristianPauly/jotit")
            }

            SettingsListItem {
                name: i18n.tr("License")
                icon: "x-office-document-symbolic"
                onClicked: Qt.openUrlExternally("https://github.com/ChristianPauly/jotit/blob/master/LICENSE")
            }

        }
    }

}
