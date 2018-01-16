/* Copyright 2016 Aditya Mehra <aix.m@outlook.com>                            

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) version 3, or any
    later version accepted by the membership of KDE e.V. (or its
    successor approved by the membership of KDE e.V.), which shall
    act as a proxy defined in Section 6 of version 3 of the license.
    
    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.
    
    You should have received a copy of the GNU Lesser General Public
    License along with this library.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Rectangle {
    id: bgrectA
    anchors.fill: parent
    color: theme.linkColor
    
    function aniRunWorking(){
        animtimer.start()
        topCircle.inneranimtopworking.start()
        maskItem.inneranimworking.start()
    }

    function aniRunTransition(){
        animtimer.start()
        topCircle.inneranimtoptransition.start()
        maskItem.inneranimtransition.start()
    }


    function aniRunHappy (){
       animtimer.start()
       topCircle.inneranimtophappy.start()
       maskItem.inneranimhappy.start()
    }

    function aniRunError(){
        animtimer.start()
        topCircle.inneranimtopsad.start()
        maskItem.inneranimsad.start()
    }

Item{
    id: customIndicatorBusy
    anchors.fill: parent
    visible: true

    RotationAnimator {
        target:topCircle
        id: antoWorking
        from: 0;
        to: 360;
        duration: 500
        running: false
        alwaysRunToEnd: true
    }

    RotationAnimator {
        target:topCircle
        id: antoTransition
        from: 0;
        to: 0;
        duration: 500
        running: false
        alwaysRunToEnd: true
    }

    RotationAnimator {
        target:topCircle
        id: antoSad
        from: 0;
        to: 180;
        duration: 500
        direction: RotationAnimator.Counterclockwise
        running: false
        alwaysRunToEnd: true;

    }

    RotationAnimator {
        target:topCircle
        id: antoHappy
        from: 0;
        to: 360;
        duration: 500
        running: false
        alwaysRunToEnd: true;
    }

    SequentialAnimation {
        id: seqmaskanimworking
        running: false
        loops: Animation.Infinite
        PropertyAction { target: myRot; property: "origin.x"; value: units.gridUnit * 1.185 }
        PropertyAction { target: myRot; property: "origin.y"; value: units.gridUnit * 1.185 }
       NumberAnimation { target: myRot; property: "angle"; from:0; to: -360; duration: 500}

       onStopped: {
           myRot.angle = 0
       }
    }

    SequentialAnimation {
        id: seqmaskanimtransition
        running: false
        loops: Animation.Infinite
        PropertyAction { target: myRot; property: "origin.x"; value: units.gridUnit * 1.185 }
        PropertyAction { target: myRot; property: "origin.y"; value: units.gridUnit * 1.185 }
        NumberAnimation { target: myRot; property: "angle"; from: 0; to: 0; duration: 500}
    }

    SequentialAnimation {
        id: colrmeonAnsHappy
        ParallelAnimation {
        PropertyAnimation { target: innerCircleSurround; property: "color"; from: "#ffffff"; to: "lightgreen"; duration: 500; }
        PropertyAnimation { target: circ; property: "color"; from: "#ffffff"; to: "lightgreen"; duration: 500; }
        PropertyAnimation { target: topCircle.circle; property: "color"; from: "#ffffff"; to: "lightgreen"; duration: 500; }
        }
        ParallelAnimation {
        PropertyAnimation { target: innerCircleSurround; property: "color"; from: "lightgreen"; to: "#fff"; duration: 500; }
        PropertyAnimation { target: circ; property: "color"; from: "lightgreen"; to: "#fff"; duration: 500; }
        PropertyAnimation { target: topCircle.circle; property: "color"; from: "lightgreen"; to: "#fff"; duration: 500; }
        }
    }

    SequentialAnimation {
        id: colrmeonAnsSad
        ParallelAnimation {
        PropertyAnimation { target: innerCircleSurround; property: "color"; from: "#ffffff"; to: "red"; duration: 500; }
        PropertyAnimation { target: circ; property: "color"; from: "#ffffff"; to: "red"; duration: 1000; }
        PropertyAnimation { target: topCircle.circle; property: "color"; from: "#ffffff"; to: "red"; duration: 500; }
        }
        ParallelAnimation {
        PropertyAnimation { target: innerCircleSurround; property: "color"; from: "red"; to: "#fff"; duration: 500; }
        PropertyAnimation { target: circ; property: "color"; from: "red"; to: "#fff"; duration: 1000; }
        PropertyAnimation { target: topCircle.circle; property: "color"; from: "red"; to: "#fff"; duration: 500; }
        }
    }

    SequentialAnimation {
        id: seqmaskanimhappy
        running: false
        loops: Animation.Infinite
        PropertyAction { target: myRot; property: "origin.x"; value: units.gridUnit * 1.185 }
        PropertyAction { target: myRot; property: "origin.y"; value: units.gridUnit * 1.185 }
       NumberAnimation { target: myRot; property: "angle"; from:0; to: -360; duration: 500}

       onStopped: {
           myRot.angle = -90
           transtimer.start()
       }

       onStarted: {
           colrmeonAnsHappy.running = true
       }
    }

    SequentialAnimation {
        id: seqmaskanimsad
        running: false
        loops: Animation.Infinite
        PropertyAction { target: myRot; property: "origin.x"; value: units.gridUnit * 1.185 }
        PropertyAction { target: myRot; property: "origin.y"; value: units.gridUnit * 1.185 }
        NumberAnimation { target: myRot; property: "angle"; from:0; to: 360; duration: 500}

       onStopped: {
           myRot.angle = 90
           transtimer.start()
       }

       onStarted: {
           colrmeonAnsSad.running = true
       }
    }

    Rectangle{
        anchors.fill: parent
        color: theme.linkColor

    Rectangle {
             id: topCircle
             anchors.horizontalCenter: parent.horizontalCenter
             anchors.verticalCenter: parent.verticalCenter
             color: "#00000000"
             radius: 1
             opacity: 1
             implicitWidth: units.gridUnit * 4.5
             implicitHeight: units.gridUnit * 4.5
             property alias inneranimtopworking: antoWorking
             property alias inneranimtophappy: antoHappy
             property alias inneranimtopsad: antoSad
             property alias inneranimtoptransition: antoTransition
             property alias circle: innerSqr

             Rectangle{
                id: innerSqr
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#fff"
                radius: 100
                width: units.gridUnit * 0.45
                height: units.gridUnit * 0.45
             }
                    }

    Rectangle {
         id: innerCircleSurround
         anchors.centerIn: parent
         color: "#ffffff"
         radius: 100
         implicitWidth: units.gridUnit * 3
         implicitHeight: units.gridUnit * 3
         opacity: 1
        }

    Rectangle {
         id: innerCircleSurroundOutterRing
         anchors.centerIn: parent
         color: theme.linkColor
         radius: 100
         implicitWidth: units.gridUnit * 2.75
         implicitHeight: units.gridUnit * 2.75
         opacity: 1
        }

    Rectangle {
        id: maskItem
         anchors.verticalCenter: parent.verticalCenter
         anchors.left: innerCircleSurroundOutterRing.left
         anchors.leftMargin: units.gridUnit * 0.2
         color: "#00000000"
         radius: 1000
         implicitWidth: units.gridUnit * 1.25
         implicitHeight: units.gridUnit * 2.4
         clip: true
         property alias cc: semicirc
         property alias inneranimworking: seqmaskanimworking
         property alias inneranimtransition: seqmaskanimtransition
         property alias inneranimhappy: seqmaskanimhappy
         property alias inneranimsad: seqmaskanimsad
         opacity: 1

         transform: Rotation {
                     id: myRot
                 }

    Item {
           id: semicirc
           anchors.left: parent.left
           anchors.top: parent.top
           anchors.bottom: parent.bottom
           width: units.gridUnit * 4.7
           clip:true
           opacity: 1

           Rectangle{
               id: circ
               width: parent.width
               height: parent.height
               radius:100
               color: "white"
         }
       }
      }

    Timer {
        id: animtimer
        interval: 500;
        repeat: false
        onTriggered: {
            maskItem.inneranimworking.stop()
            maskItem.inneranimtransition.stop()
            maskItem.inneranimhappy.stop()
            maskItem.inneranimsad.stop()
            topCircle.inneranimtopworking.stop()
            topCircle.inneranimtoptransition.stop()
            topCircle.inneranimtophappy.stop()
            topCircle.inneranimtopsad.stop()
            }
        }

    Timer {
        id: transtimer
        interval: 500;
        repeat: false
        onTriggered: {
            myRot.angle = 0
            antoTransition.running = true
                    }
                }
            }
        }
      }
