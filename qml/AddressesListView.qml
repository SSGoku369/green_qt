import Blockstream.Green 0.1
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

ColumnLayout {
    required property Account account
    signal clicked(Address address)

    id: self
    Layout.fillWidth: true
    Layout.fillHeight: true

    RowLayout {
        Layout.fillWidth: true
        Layout.preferredHeight: 50

        ToolButton {
            icon.source: "qrc:/svg/search.svg"
            icon.width: 24
            icon.height: 24
            icon.color: 'white'
        }

        TextField {
            id: search_field
            Layout.fillWidth: true
            placeholderText: qsTrId('id_search_address')
            onTextChanged: address_model_filter.search(text)
        }

        ToolButton {
            visible: search_field.text.length>0
            icon.source: "qrc:/svg/cancel.svg"
            icon.width: 12
            icon.height: 12
            icon.color: 'white'
            padding: 0
            onClicked: {
                search_field.clear()
                address_model_filter.clear()
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true
        Layout.leftMargin: constants.p1
        Layout.rightMargin: constants.p1
        Layout.preferredHeight: 50
        spacing: constants.p3
        Label {
            Layout.fillWidth: true
            elide: Text.ElideRight
            text: qsTrId('id_address')
            font.pixelSize: 16
            font.styleName: 'Medium'
        }
        Label {
            text: qsTrId('Type')
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 16
            font.styleName: 'Medium'
            Layout.minimumWidth: 50
        }
        Label {
            text: qsTrId('Tx count')
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 16
            font.styleName: 'Medium'
            Layout.minimumWidth: 50
        }
    }

    ListView {
        id: list_view
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        spacing: 8
        model: AddressListModelFilter {
            id: address_model_filter
            model: AddressListModel {
                id: address_model
                account: self.account
            }
        }
        delegate: AddressDelegate {
            hoverEnabled: false
            width: list_view.width
            onClicked: self.clicked(address)
        }

        ScrollIndicator.vertical: ScrollIndicator { }

        BusyIndicator {
            width: 32
            height: 32
            running: address_model.fetching
            anchors.margins: 8
            Layout.alignment: Qt.AlignHCenter
            opacity: address_model.fetching ? 1 : 0
            Behavior on opacity { OpacityAnimator {} }
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}