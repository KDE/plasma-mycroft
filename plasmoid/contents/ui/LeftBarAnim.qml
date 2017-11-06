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

Item {
property bool wsocketMsg: false

function wsocmsganimtoggle() { onreadyanim.running = true; }

        SequentialAnimation {
         id: onconanim
         ParallelAnimation{
            PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.horizontalCenterOffset"
                    from: 0
                    to: 9
                    duration: 300
                }

            PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.verticalCenterOffset"
                    from: -13
                    to: -9
                    duration: 300
                    }
                }

            ParallelAnimation{
                PropertyAnimation {
                        target: canvascentersmallgraphic
                        property: "anchors.horizontalCenterOffset"
                        from: 9
                        to: 10.5
                        duration: 300
                    }

            PropertyAnimation {
                        target: canvascentersmallgraphic
                        property: "anchors.verticalCenterOffset"
                        from: -9
                        to: -6
                        duration: 300
                        }
                    }
            ParallelAnimation{

             PropertyAnimation {
                        target: canvascentersmallgraphic
                        property: "anchors.horizontalCenterOffset"
                        from: 10.5
                        to: 11.5
                        duration: 300
                    }

            PropertyAnimation {
                        target: canvascentersmallgraphic
                        property: "anchors.verticalCenterOffset"
                        from: -6
                        to: 6
                        duration: 300
                        }
                    }

        ParallelAnimation{

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.horizontalCenterOffset"
                    from: 11.5
                    to: 10.5
                    duration: 300
                }

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.verticalCenterOffset"
                    from: 6
                    to: 9
                    duration: 300
                    }
                }

        ParallelAnimation{

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.horizontalCenterOffset"
                    from: 10.5
                    to: 0
                    duration: 300
                }

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.verticalCenterOffset"
                    from: 9
                    to: 13
                    duration: 300
                    }
                }

        ParallelAnimation{

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.horizontalCenterOffset"
                    from: 0
                    to: -9
                    duration: 300
                }

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.verticalCenterOffset"
                    from: 13
                    to: 9
                    duration: 300
                    }
                }

        ParallelAnimation{

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.horizontalCenterOffset"
                    from: -9
                    to: -10.5
                    duration: 300
                }

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.verticalCenterOffset"
                    from: 9
                    to: 6
                    duration: 300
                    }
                }

        ParallelAnimation{

         PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.horizontalCenterOffset"
                    from: -10.5
                    to: -11.5
                    duration: 300
                }

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.verticalCenterOffset"
                    from: 6
                    to: -6
                    duration: 300
                    }
                }
        ParallelAnimation{

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.horizontalCenterOffset"
                    from: -11.5
                    to: -10.5
                    duration: 300
                }

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.verticalCenterOffset"
                    from: -6
                    to: -9
                    duration: 300
                    }
                }
        ParallelAnimation{

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.horizontalCenterOffset"
                    from: -10.5
                    to: 0
                    duration: 300
                }

        PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.verticalCenterOffset"
                    from: -9
                    to: -13
                    duration: 300
                    }
                }
        }

        SequentialAnimation {
         id: onreadyanim
            PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.verticalCenterOffset"
                    from: -8
                    to: 0
                    duration: 200
                }

            ParallelAnimation {
             PropertyAnimation {
                   target: canvascenterhalfgraphic;
                   property: "mpie";
                   from: 3
                   to: 4
                   duration: 600
                   }

             PropertyAnimation {
                target: canvascentersmallgraphic;
                property: "mpie";
                from: 1
                to: 6
                duration: 600
                }

//              RotationAnimator {
//                  target: canvascenterbiggraphic;
//                  from: 0;
//                  to: 720;
//                  duration: 2000
//                 }
// 
//              RotationAnimator {
//                  target: canvascenterbggraphic;
//                  from: 0;
//                  to: 90;
//                  duration: 1000
//                 }
            }

         ParallelAnimation{
            PropertyAnimation {
                    target: canvascentersmallgraphic
                    property: "anchors.verticalCenterOffset"
                    from: 0
                    to: -8
                    duration: 200
                }
             PropertyAnimation {
                target: canvascentersmallgraphic;
                property: "mpie";
                from: 6
                to: 1
                duration: 200
                }

             PropertyAnimation {
                   target: canvascenterhalfgraphic;
                   property: "mpie";
                   from: 4
                   to: 3
                   duration: 600
                   }

//              RotationAnimator {
//                  target: canvascenterbggraphic;
//                  from: 90;
//                  to: 0;
//                  duration: 1000
//                 }

            }
        }



            Canvas {
                        id:canvascenterbggraphic
                        width: parent.width
                        height: parent.height
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter

                        property color strokeStyle:  Qt.darker(fillStyle, 1.5)
                        property color fillStyle: Qt.darker("deepskyblue", 1.1)
                        property real lineWidth: 1.6
                        property bool fill: true
                        property bool stroke: false
                        property real alpha: 1.0
                        property real scale : 1
                        property real rotate : 0
                        antialiasing: true
                        smooth: true

                        onLineWidthChanged:requestPaint();
                        onFillChanged:requestPaint();
                        onStrokeChanged:requestPaint();
                        //onScaleChanged:requestPaint();
                        onRotateChanged:requestPaint();

                        renderTarget: Canvas.FramebufferObject
                        renderStrategy: Canvas.Cooperative


            onPaint: {
                            var ctxside = canvascenterbggraphic.getContext('2d');
                            var hCenter = width * 0.5
                            var vCenter = height * 0.5
                            var numberOfSides = 6
                            var size = 12

                            ctxside.save();
                            ctxside.clearRect(0, 0, canvascenterbggraphic.width, canvascenterbggraphic.height);
                            ctxside.globalAlpha = canvascenterbggraphic.alpha;
                            ctxside.strokeStyle = canvascenterbggraphic.strokeStyle;
                            ctxside.fillStyle = canvascenterbggraphic.fillStyle;
                            ctxside.lineWidth = canvascenterbggraphic.lineWidth;
                            ctxside.scale(canvascenterbggraphic.scale, canvascenterbggraphic.scale);
                            ctxside.rotate(canvascenterbggraphic.rotate);
                            ctxside.lineJoin = "round";
                            ctxside.lineCap = "round";

                            ctxside.beginPath();
                            ctxside.moveTo(hCenter +  size * Math.sin(0), vCenter +  size *  Math.cos(0));

                           for (var i = 1; i <= numberOfSides;i += 1) {
                            ctxside.lineTo(hCenter + size * Math.sin(i * 2 * Math.PI / numberOfSides), vCenter + size * Math.cos(i * 2 * Math.PI / numberOfSides));
                            }
                            ctxside.closePath();
                            ctxside.fill();
                            ctxside.stroke();

                            if (canvascenterbggraphic.fill)
                               ctxside.fill();
                            if (canvascenterbggraphic.stroke)
                               ctxside.stroke();
                               ctxside.restore();
                }
             }

            Canvas {
                                id:canvascenterbiggraphic
                                width: parent.width
                                height: parent.height
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: 0;
                                anchors.verticalCenterOffset: 0;
                                transformOrigin: Item.Center
                                //anchors.left: canvasleftline.left

                                //property real viewScale: base.parent.scale

                                property color strokeStyle:  "white"//Qt.darker("white", 1.4)
                                property color fillStyle: "lightsteelblue" // red
                                property real lineWidth: 1.2
                                property bool fill: false
                                property bool stroke: false
                                property real alpha: 1.0
                                property real scale : 1
                                property real rotate : 0
                                property real mpie: 5
                                antialiasing: true
                                smooth: true

                                onLineWidthChanged:requestPaint();
                                onFillChanged:requestPaint();
                                onStrokeChanged:requestPaint();
                                onScaleChanged:requestPaint();
                                onRotateChanged:requestPaint();
                                onFillStyleChanged:requestPaint();

                            renderTarget: Canvas.FramebufferObject
                                renderStrategy: Canvas.Cooperative


                    onPaint: {
                                    var ctxcircle = canvascenterbiggraphic.getContext('2d');
                                    var offleftcenter = width * 0.50
                                    var offrightcenter = width * 0.50
                                    var vCenter = height * 0.5
                                    var vDelta = height / 6

                                    ctxcircle.save();
                                    ctxcircle.clearRect(0, 0, canvascenterbiggraphic.width, canvascenterbiggraphic.height);
                                    ctxcircle.globalAlpha = canvascenterbiggraphic.alpha;
                                    ctxcircle.strokeStyle = canvascenterbiggraphic.strokeStyle;
                                    ctxcircle.fillStyle = canvascenterbiggraphic.fillStyle;
                                    ctxcircle.lineWidth = canvascenterbiggraphic.lineWidth;
                                    ctxcircle.scale(canvascenterbiggraphic.scale, canvascenterbiggraphic.scale);
                                    ctxcircle.rotate(canvascenterbiggraphic.rotate)

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter, vCenter, mpie, 10 * Math.PI, false);
                        ctxcircle.stroke();

                        if (canvascenterbiggraphic.stroke)
                           ctxcircle.stroke();
                           ctxcircle.restore();

                            }
                        }
            Canvas {
                                id:canvascenterhalfgraphic
                                width: parent.width
                                height: parent.height
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: 0;
                                anchors.verticalCenterOffset: 0;
                                //anchors.left: canvasleftline.left

                                //property real viewScale: base.parent.scale

                                property color strokeStyle:  "white"//Qt.darker("white", 1.4)
                                property color fillStyle: "white" // red
                                property real lineWidth: 1.2
                                property bool fill: false
                                property bool stroke: false
                                property real alpha: 1.0
                                property real scale : 1
                                property real rotate : 0
                                property real mpie: 3
                                antialiasing: true
                                smooth: true

                                onLineWidthChanged:requestPaint();
                                onFillChanged:requestPaint();
                                onStrokeChanged:requestPaint();
                                onScaleChanged:requestPaint();
                                onRotateChanged:requestPaint();
                                onFillStyleChanged:requestPaint();
                                onMpieChanged: requestPaint();

                            renderTarget: Canvas.FramebufferObject
                                renderStrategy: Canvas.Cooperative


                    onPaint: {
                                    var ctxcircle = canvascenterhalfgraphic.getContext('2d');
                                    var offleftcenter = width * 0.50
                                    var offrightcenter = width * 0.50
                                    var vCenter = height * 0.5
                                    var vDelta = height / 6

                                    ctxcircle.save();
                                    ctxcircle.clearRect(0, 0, canvascenterhalfgraphic.width, canvascenterhalfgraphic.height);
                                    ctxcircle.globalAlpha = canvascenterhalfgraphic.alpha;
                                    ctxcircle.strokeStyle = canvascenterhalfgraphic.strokeStyle;
                                    ctxcircle.fillStyle = canvascenterhalfgraphic.fillStyle;
                                    ctxcircle.lineWidth = canvascenterhalfgraphic.lineWidth;
                                    ctxcircle.scale(canvascenterhalfgraphic.scale, canvascenterhalfgraphic.scale);
                                    ctxcircle.rotate(canvascenterhalfgraphic.rotate);

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter, vCenter, mpie,  2.5 * Math.PI, 3.5 * Math.PI , false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        if (canvascenterhalfgraphic.stroke)
                           ctxcircle.stroke();
                           ctxcircle.restore();
                            }
                        }

            Canvas {
                                id:canvascentersmallgraphic
                                width: parent.width
                                height: parent.height
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.horizontalCenterOffset: 0;
                                anchors.verticalCenterOffset: -8;
                                //anchors.left: canvasleftline.left

                                //property real viewScale: base.parent.scale

                                property color strokeStyle:  "white"//Qt.darker("white", 1.4)
                                property color fillStyle: "white" // red
                                property real lineWidth: 0.4
                                property bool fill: false
                                property bool stroke: false
                                property real alpha: 1.0
                                property real scale : 1
                                property real rotate : 0
                                property real mpie: 1
                                antialiasing: true

                                onLineWidthChanged:requestPaint();
                                onFillChanged:requestPaint();
                                onStrokeChanged:requestPaint();
                                onScaleChanged:requestPaint();
                                onRotateChanged:requestPaint();
                                onFillStyleChanged:requestPaint();
                                onMpieChanged: requestPaint();

                            renderTarget: Canvas.FramebufferObject
                                renderStrategy: Canvas.Cooperative


                    onPaint: {
                                    var ctxcircle = canvascentersmallgraphic.getContext('2d');
                                    var offleftcenter = width * 0.50
                                    var offrightcenter = width * 0.50
                                    var vCenter = height * 0.5
                                    var vDelta = height / 6

                                    ctxcircle.save();
                                    ctxcircle.clearRect(0, 0, canvascentersmallgraphic.width, canvascentersmallgraphic.height);
                                    ctxcircle.globalAlpha = canvascentersmallgraphic.alpha;
                                    ctxcircle.strokeStyle = canvascentersmallgraphic.strokeStyle;
                                    ctxcircle.fillStyle = canvascentersmallgraphic.fillStyle;
                                    ctxcircle.lineWidth = canvascentersmallgraphic.lineWidth;
                                    ctxcircle.scale(canvascentersmallgraphic.scale, canvascentersmallgraphic.scale);
                                    ctxcircle.rotate(canvascentersmallgraphic.rotate);

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter, vCenter, mpie, 10 * Math.PI , false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        if (canvascentersmallgraphic.stroke)
                           ctxcircle.stroke();
                           ctxcircle.restore();
                            }
                        }
        }
