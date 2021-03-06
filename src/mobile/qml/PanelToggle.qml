/****************************************************************************
 *   Copyright (C) 2012  Instituto Nokia de Tecnologia (INdT)               *
 *                                                                          *
 *   This file may be used under the terms of the GNU Lesser                *
 *   General Public License version 2.1 as published by the Free Software   *
 *   Foundation and appearing in the file LICENSE.LGPL included in the      *
 *   packaging of this file.  Please review the following information to    *
 *   ensure the GNU Lesser General Public License version 2.1 requirements  *
 *   will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.   *
 *                                                                          *
 *   This program is distributed in the hope that it will be useful,        *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of         *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          *
 *   GNU Lesser General Public License for more details.                    *
 ****************************************************************************/

import QtQuick 2.0

Image {
    id: panelToggle

    property bool topSitesEnabled: false
    property bool navigationEnabled: true
    property bool overrideNavigationEnabled: false
    property alias topSitesButtonSelected: topsites.visible

    signal topSitesSelected()
    signal tabsSelected()

    onTopSitesEnabledChanged: {
        if (!topSitesEnabled) {
            topsites.visible = false;
            tabsSelected();
        }
    }

    onNavigationEnabledChanged: {
        topsites.visible = !navigationEnabled && topSitesEnabled;
    }

    source: topSitesEnabled && navigationEnabled ? "qrc:///mobile/app/menu_unpressed" : "qrc:///mobile/app/menu_disabled"

    Image {
        id: topsites
        source: "qrc:///mobile/app/mysites_pressed"
        visible: false
    }
    MouseArea {
        anchors.fill: topsites
        visible: topSitesEnabled
        onClicked: {
            topsites.visible = true;
            topSitesSelected();
        }
    }

    Image {
        id: tabs
        source: "qrc:///mobile/app/tabs_pressed"
        anchors.right:  parent.right
        visible: !topsites.visible

    }
    MouseArea {
        anchors.fill: tabs
        visible: navigationEnabled || !topSitesEnabled
        onClicked: {
            topsites.visible = false;
            tabsSelected();
        }
    }
}

