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
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {

   property alias topanimrun: seqrun.running 
    
   //anchors.fill: parent
   function wsistalking() {
            if(statusId.visible == true){
            numanimtest.running = true
            seqrun.running = false
        }
        else if(statusId.visible == false){
            seqrun.running = true
            canvasmiddlegraphics.visible = !canvasmiddlegraphics.visible
        }
} 

    function showstatsId() {
        canvasmiddlegraphics.opacity = 0
        statusId.visible = true
    }
    
    SequentialAnimation{
        id: numanimtest
        
    SequentialAnimation {  
         
    PropertyAnimation {
        id: n1test
        target: statusId
        property: "opacity"
        from: 1;
        to: 0;
        duration: 3000
        }     
        
    PropertyAnimation {
        id: n1testr
        target: statusId
        property: "visible"
        from: true;
        to: false;
        duration: 2000
        }
        
    PropertyAnimation {
        id: n1testn
        target: statusId
        property: "opacity"
        from: 0;
        to: 1;
        duration: 20
        }     
    }
            
    NumberAnimation{
        id: n2testop
        target: canvasmiddlegraphics
        property: "opacity"
        from: 0;
        to: 1;
        duration: 300
    }            
}

   SequentialAnimation {
        id: seqrun
        
        ParallelAnimation {
        NumberAnimation{
        target: canvasmiddlegraphics
        property: "i"
        from: -50
        to: -70
        duration: 200
        }

        SequentialAnimation {
            loops: 10
            
            ParallelAnimation {
            NumberAnimation{
            target: canvasmiddlegraphics
            property: "amplitude"
            from: 0
            to: 10 + Math.floor(Math.random() * 6) + 1  
            duration: 12
            }
                }
            
            ParallelAnimation {
            NumberAnimation{
            target: canvasmiddlegraphics
            property: "amplitude"
            from: 10
            to: 16 + Math.floor(Math.random() * 2) + 1  
            duration: 12

                }
            }

            ParallelAnimation{
            NumberAnimation{
            target: canvasmiddlegraphics
            property: "amplitude"
            from: 16 + Math.floor(Math.random() * 2) + 1
            to: 10 + Math.floor(Math.random() * 6) + 1
            duration: 12
                }
                }
                
            ParallelAnimation {    
            NumberAnimation{
            target: canvasmiddlegraphics
            property: "amplitude"
            from: 10 + Math.floor(Math.random() / 6) + 1
            to: 0
            duration: 12
                } 

            }
            }
        }

        ParallelAnimation {
        
        PropertyAnimation {
            target: canvasmiddlegraphics
            property: "visible"
            from: true
            to: false
            duration: 20
            }
        }
    }
    
    Canvas {
                          id:canvasmiddlegraphics
                          width: parent.width
                          height: parent.height
                          anchors.verticalCenter: parent.verticalCenter
                          anchors.horizontalCenter: parent.horizontalCenter
                          visible: true
                          opacity: 0

                          property color strokeStyle:  Qt.darker(fillStyle, 1.5)
                          property color fillStyle: Qt.darker(theme.linkColor, 1.1)
                          property real lineWidth: 1.6
                          property bool fill: true
                          property bool stroke: false
                          property real alpha: 1.0
                          property real scale : 1
                          property real rotate : 0
                          property real i: -50
                          property real waveSpeed: 10
                          property real amplitude: 0
                          antialiasing: true
                          smooth: true

                          onLineWidthChanged:requestPaint();
                          onFillChanged:requestPaint();
                          onStrokeChanged:requestPaint();
                          onScaleChanged:requestPaint();
                          onRotateChanged:requestPaint();
                          onIChanged: requestPaint();

                          renderTarget: Canvas.FramebufferObject
                          renderStrategy: Canvas.Cooperative


              onPaint: {
                              var ctxside = canvasmiddlegraphics.getContext('2d');
                              var ctxside2 = canvasmiddlegraphics.getContext('2d');
                              var hCenter = width * 0.5
                              var vCenter = height * 0.5
                              var size = 12
                              var period = 15;
                              var dotSpeed = 5;

                              function draw_line(i){
                                  var oStartx=0;
                                  var oStarty=( height / 2 )
                                  ctxside.beginPath();
                                  ctxside.moveTo( oStartx, oStarty + amplitude * Math.sin( x / period + ( i  / 5 ) ) );
                                  ctxside.lineWidth = 1;
                                  ctxside.strokeStyle = theme.linkColor;

                                  for(var Vx = oStartx; Vx < width * 0.95; Vx++) {
                                      var Vy = amplitude * Math.sin( Vx / period + ( i  / 5 + Math.floor(Math.random() * 2) + 0));
                                      ctxside.lineTo( oStartx + Vx,  oStarty + Vy);
                                  }

                                   ctxside.stroke();
                              }
                              
                              
                              function draw_line_rev(i){
                                  var oStartx=-10;
                                  var oStarty=(height / 2)
                                  ctxside2.beginPath();
                                  ctxside2.moveTo( oStartx, oStarty + amplitude * Math.sin( x / period + ( i  / 5 ) ) );
                                  ctxside2.lineWidth = 2;
                                  ctxside2.strokeStyle = theme.linkColor;

                                  for(var Vx = Math.random(oStartx); Vx < width * 1; Vx++) {
                                      var Vy = Math.random() * amplitude * Math.sin( Vx / period + ( i  / 5 + Math.floor(Math.random() * 2) + 0));
                                      ctxside2.lineTo( oStartx + Vx,  oStarty + Vy);
                                  }

                                   ctxside2.stroke();
                              }
                                

                              function render(){
                                  var st = i
                                  ctxside.clearRect(0, 0, width, height);
                                  ctxside2.clearRect(0, 0, width, height);
                                  draw_line(st)
                                  draw_line_rev(st)
                              }
                  render();
              }
    }
}
