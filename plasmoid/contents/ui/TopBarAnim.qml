import QtQuick 2.0

Item {

   anchors.fill: parent

    property bool arrowFormState: false
        function toggle() { arrowFormState = !arrowFormState }
        
    property bool wsocketRunning: false
        function wsocrunninganimtoggle() { wsocketRunning = !wsocketRunning, 
                                                            onrunninanim.running = true; }

    property bool wsocketError: false
        function wsocerroranimtoggle() { wsocketError = !wsocketError,
                                                            onerroranim.running = true; }

    property bool wsocketClosed: false
        function wsocclosedanimtoggle() { wsocketClosed = !wsocketClosed }
        
    property bool wsocketMsg: false
        function wsocmsganimtoggle() { onmsganim.running = true; } 
        
        
        StateGroup {
            id: lineanimstategrp
            states: [                    
                State {
                name: "runninganimstate"
                when: wsocketRunning
                PropertyChanges { anchors.leftMargin: -50; target: canvasleftline }
                PropertyChanges { anchors.rightMargin: -50; target: canvasrightline }
                },

                State {
                name: "erroranimstate"
                when: wsocketError
                PropertyChanges { anchors.leftMargin: -50; target: canvasleftline }
                PropertyChanges { anchors.rightMargin: -50; target: canvasrightline }
                },

                State {
                name: "closedanimstate"
                when: wsocketClosed
                PropertyChanges { anchors.leftMargin: 0; target: canvasleftline }
                PropertyChanges { anchors.rightMargin: 0; target: canvasrightline }
                },

                State {
                name: "msganimstate"
                when: wsocketMsg
                PropertyChanges { anchors.leftMargin: -50; target: canvasleftline }
                PropertyChanges { anchors.rightMargin: -50; target: canvasrightline }
                }
                    ]
                                    
           transitions: Transition {
                PropertyAnimation {
                property: "anchors.leftMargin"
                easing.type: Easing.Linear
                duration: 500
            }
                PropertyAnimation {
                property: "anchors.rightMargin"
                easing.type: Easing.Linear
                duration: 500
            }
            
                onRunningChanged:{
                    if( running === false) {
                        lineanimstategrp.state = "closedanimstate"
                        }
                    }                         
            
            }
        }
        
        SequentialAnimation {
         id: onrunninanim
            PropertyAnimation {
                target: canvascentergraphic
                property: "fillStyle"
                to: "green"
                duration: 1
            }
            PropertyAnimation {
                target: canvascentergraphic
                property: "fillStyle"
                to: "grey"
                duration: 1000
            }
        }
        
        SequentialAnimation {
         id: onerroranim
            PropertyAnimation {
                target: canvascentergraphic
                property: "fillStyle"
                to: "red"
                duration: 1
            }
            PropertyAnimation {
                target: canvascentergraphic
                property: "fillStyle"
                to: "grey"
                duration: 500
            }
        }
        
        SequentialAnimation {
         id: onmsganim
         ParallelAnimation{
            PropertyAnimation {
                    target: canvasleftline
                    property: "anchors.leftMargin"
                    from: 0
                    to: -50
                    duration: 200
                }
                
            PropertyAnimation {
                    target: canvasrightline
                    property: "anchors.rightMargin"
                    from: 0
                    to: -50
                    duration: 200
                }    
                
            PropertyAnimation {
                target: canvascentergraphic
                property: "fillStyle"
                to: "blue"
                duration: 10
            }
         }
        
        ParallelAnimation{
            PropertyAnimation {
                    target: canvasleftline
                    property: "anchors.leftMargin"
                    from: - 50
                    to: 0
                    duration: 200
                }
                
            PropertyAnimation {
                    target: canvasrightline
                    property: "anchors.rightMargin"
                    from: - 50
                    to: 0
                    duration: 200
                }    
         
            PropertyAnimation {
                target: canvascentergraphic
                property: "fillStyle"
                to: "grey"
                duration: 1000
                }
            }
        }
        
            Canvas {
                        id:canvasleftline
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        property color strokeStyle:  Qt.darker(fillStyle, 1.4)
                        property color fillStyle: "lightgrey" // red
                        property int lineWidth: 1
                        property bool fill: false
                        property bool stroke: false
                        property real alpha: 1.0
                        property real scale : 1
                        property real rotate : 0
                        antialiasing: true

                        onLineWidthChanged:requestPaint();
                        onFillChanged:requestPaint();
                        onStrokeChanged:requestPaint();
                        onScaleChanged:requestPaint();
                        onRotateChanged:requestPaint();

                    renderTarget: Canvas.FramebufferObject
                        renderStrategy: Canvas.Cooperative


            onPaint: {
                            var ctxside = canvasleftline.getContext('2d');
                            var left = 0
                            var right = width / 2
                            var offleftcenter = width * 0.30
                            var offrightcenter = width * 0.58
                            var vCenter = height * 0.5
                            var vDelta = height / 2

                            ctxside.save();
                            ctxside.clearRect(0, 0, canvasleftline.width, canvasleftline.height);
                            ctxside.globalAlpha = canvasleftline.alpha;
                            ctxside.strokeStyle = canvasleftline.strokeStyle;
                            ctxside.fillStyle = canvasleftline.fillStyle;
                            ctxside.lineWidth = canvasleftline.lineWidth;
                            ctxside.scale(canvasleftline.scale, canvasleftline.scale);
                            ctxside.rotate(canvasleftline.rotate);

                            //Left Line
                            ctxside.beginPath()
                            ctxside.moveTo(offleftcenter, vCenter)
                            ctxside.lineTo(left, vCenter)
                            ctxside.stroke()

                            if (canvasleftline.fill)
                               ctxside.fill();
                            if (canvasleftline.stroke)
                               ctxside.stroke();
                               ctxside.restore();
                }
             }

        Canvas {
                    id:canvasrightline
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    property color strokeStyle:  Qt.darker(fillStyle, 1.4)
                    property color fillStyle: "lightgrey" // red
                    property int lineWidth: 1
                    property bool fill: false
                    property bool stroke: false
                    property real alpha: 1.0
                    property real scale : 1
                    property real rotate : 0
                    antialiasing: true

                    onLineWidthChanged:requestPaint();
                    onFillChanged:requestPaint();
                    onStrokeChanged:requestPaint();
                    onScaleChanged:requestPaint();
                    onRotateChanged:requestPaint();

                    renderTarget: Canvas.FramebufferObject
                    renderStrategy: Canvas.Cooperative


        onPaint: {
                        var ctxside = canvasrightline.getContext('2d');
                        var left = 0
                        var right = width
                        var offleftcenter = width * 0.30
                        var offrightcenter = width / 1.65
                        var vCenter = height * 0.5
                        var vDelta = height / 6

                        ctxside.save();
                        ctxside.clearRect(0, 0, canvasrightline.width, canvasrightline.height);
                        ctxside.globalAlpha = canvasrightline.alpha;
                        ctxside.strokeStyle = canvasrightline.strokeStyle;
                        ctxside.fillStyle = canvasrightline.fillStyle;
                        ctxside.lineWidth = canvasrightline.lineWidth;
                        ctxside.scale(canvasrightline.scale, canvasrightline.scale);
                        ctxside.rotate(canvasrightline.rotate);

                        //Right Line
                        ctxside.beginPath()
                        ctxside.moveTo(offrightcenter, vCenter)
                        ctxside.lineTo(right, vCenter)
                        ctxside.stroke()

                        if (canvasrightline.fill)
                           ctxside.fill();
                        if (canvasrightline.stroke)
                           ctxside.stroke();
                           ctxside.restore();
            }
         }

        Canvas {
                    id:canvasleftgraphic
                    width: 100
                    height: 150
                    anchors.verticalCenter: canvasleftline.verticalCenter
                    anchors.horizontalCenter: canvasleftline.horizontalCenter
                    anchors.horizontalCenterOffset: -35;
                    anchors.verticalCenterOffset: 0;
                    //anchors.left: canvasleftline.left

                    property color strokeStyle:  Qt.darker(fillStyle, 1.4)
                    property color fillStyle: "lightgrey" // red
                    property int lineWidth: 1
                    property bool fill: false
                    property bool stroke: false
                    property real alpha: 1.0
                    property real scale : 1
                    property real rotate : 0
                    antialiasing: true

                    onLineWidthChanged:requestPaint();
                    onFillChanged:requestPaint();
                    onStrokeChanged:requestPaint();
                    onScaleChanged:requestPaint();
                    onRotateChanged:requestPaint();

                renderTarget: Canvas.FramebufferObject
                    renderStrategy: Canvas.Cooperative


        onPaint: {
                        var ctxside = canvasleftgraphic.getContext('2d');
                        var offleftcenter = width * 0.27
                        var offrightcenter = width * 0.58
                        var vCenter = height * 0.5
                        var vDelta = height / 6

                        ctxside.save();
                        ctxside.clearRect(0, 0, canvasleftgraphic.width, canvasleftgraphic.height);
                        ctxside.globalAlpha = canvasleftgraphic.alpha;
                        ctxside.strokeStyle = canvasleftgraphic.strokeStyle;
                        ctxside.fillStyle = canvasleftgraphic.fillStyle;
                        ctxside.lineWidth = canvasleftgraphic.lineWidth;
                        ctxside.scale(canvasleftgraphic.scale, canvasleftgraphic.scale);
                        ctxside.rotate(canvasleftgraphic.rotate);
                        ctxside.lineJoin = "bevel";

                //Left Logo
                        ctxside.beginPath();
                        ctxside.moveTo(offleftcenter + 20, vCenter - 30);
                        ctxside.lineTo(offleftcenter + 0, vCenter);
                        ctxside.lineTo(offleftcenter + 20, vCenter + 30);
                        ctxside.lineTo(offleftcenter + 20, vCenter + 30);
                        ctxside.lineTo(offleftcenter + 05, vCenter);
                        ctxside.lineTo(offleftcenter + 20, vCenter - 30);
                        ctxside.closePath();
                        ctxside.fill();
                        ctxside.stroke();

                        ctxside.beginPath();
                        ctxside.moveTo(offleftcenter + 20, vCenter + 30);
                        ctxside.lineTo(offleftcenter + 30, vCenter + 30);
                        ctxside.moveTo(offleftcenter + 20, vCenter - 30);
                        ctxside.lineTo(offleftcenter + 30, vCenter - 30);
                        ctxside.stroke();

                        if (canvasleftgraphic.fill)
                           ctxside.fill();
                        if (canvasleftgraphic.stroke)
                           ctxside.stroke();
                           ctxside.restore();
            }
         }

        Canvas {
                    id:canvasrightgraphic
                    width: 300
                    height: 150
                    anchors.verticalCenter: canvasrightline.verticalCenter
                    anchors.horizontalCenter: canvasrightline.horizontalCenter
                    anchors.horizontalCenterOffset: 0;
                    anchors.verticalCenterOffset: 0;
                    //anchors.left: canvasleftline.left

                    property color strokeStyle:  Qt.darker(fillStyle, 1.4)
                    property color fillStyle: "lightgrey" // red
                    property int lineWidth: 1
                    property bool fill: true
                    property bool stroke: true
                    property real alpha: 1.0
                    property real scale : 1
                    property real rotate : 0
                    antialiasing: true

                    onLineWidthChanged:requestPaint();
                    onFillChanged:requestPaint();
                    onStrokeChanged:requestPaint();
                    onScaleChanged:requestPaint();
                    onRotateChanged:requestPaint();

                    renderTarget: Canvas.FramebufferObject
                    renderStrategy: Canvas.Cooperative


        onPaint: {
                        var ctxside = canvasrightgraphic.getContext('2d');
                        var offleftcenter = width * 0.30
                        var offrightcenter = width * 0.58
                        var vCenter = height * 0.5
                        var vDelta = height / 6

                        ctxside.save();
                        ctxside.clearRect(0, 0, canvasrightgraphic.width, canvasrightgraphic.height);
                        ctxside.globalAlpha = canvasrightgraphic.alpha;
                        ctxside.strokeStyle = canvasrightgraphic.strokeStyle;
                        ctxside.fillStyle = canvasrightgraphic.fillStyle;
                        ctxside.lineWidth = canvasrightgraphic.lineWidth;
                        ctxside.scale(canvasrightgraphic.scale, canvasrightgraphic.scale);
                        ctxside.rotate(canvasrightgraphic.rotate);
                        ctxside.lineJoin = "bevel";

                    //Right Logo
                        ctxside.beginPath();
                        ctxside.moveTo(offleftcenter + 70, vCenter - 30);
                        ctxside.lineTo(offleftcenter + 90, vCenter);
                        ctxside.lineTo(offleftcenter + 70, vCenter + 30);
                        ctxside.lineTo(offleftcenter + 70, vCenter + 30);
                        ctxside.lineTo(offleftcenter + 85, vCenter);
                        ctxside.lineTo(offleftcenter + 70, vCenter - 30);
                        ctxside.closePath();
                        ctxside.fill();
                        ctxside.stroke();

                        ctxside.beginPath();
                        ctxside.moveTo(offleftcenter + 70, vCenter + 30);
                        ctxside.lineTo(offleftcenter + 60, vCenter + 30);
                        ctxside.moveTo(offleftcenter + 70, vCenter - 30);
                        ctxside.lineTo(offleftcenter + 60, vCenter - 30);
                        ctxside.fill();
                        ctxside.stroke();

                        if (canvasrightgraphic.fill)
                           ctxside.fill();
                        if (canvasrightgraphic.stroke)
                           ctxside.stroke();
                           ctxside.restore();
            }
     }

        Canvas {
                    id:canvascentergraphic
                    width: parent.width
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: 0;
                    anchors.verticalCenterOffset: 0;
                    //anchors.left: canvasleftline.left

                    property color strokeStyle:  Qt.darker(fillStyle, 1.4)
                    property color fillStyle: "lightgrey" // red
                    property int lineWidth: 1
                    property bool fill: false
                    property bool stroke: false
                    property real alpha: 1.0
                    property real scale : 1
                    property real rotate : 0
                    antialiasing: true
    
                    onLineWidthChanged:requestPaint();
                    onFillChanged:requestPaint();
                    onStrokeChanged:requestPaint();
                    onScaleChanged:requestPaint();
                    onRotateChanged:requestPaint();
                    onFillStyleChanged:requestPaint();

                renderTarget: Canvas.FramebufferObject
                    renderStrategy: Canvas.Cooperative


        onPaint: {
                        var ctxcircle = canvascentergraphic.getContext('2d');
                        var offleftcenter = width / 2
                        var offrightcenter = width / 2
                        var vCenter = height * 0.5
                        var vDelta = height / 6

                        ctxcircle.save();
                        ctxcircle.clearRect(0, 0, canvascentergraphic.width, canvascentergraphic.height);
                        ctxcircle.globalAlpha = canvascentergraphic.alpha;
                        ctxcircle.strokeStyle = canvascentergraphic.strokeStyle;
                        ctxcircle.fillStyle = canvascentergraphic.fillStyle;
                        ctxcircle.lineWidth = canvascentergraphic.lineWidth;
                        ctxcircle.scale(canvascentergraphic.scale, canvascentergraphic.scale);
                        ctxcircle.rotate(canvascentergraphic.rotate);

                //Top Row
                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 10, vCenter - 30, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 20, vCenter - 30, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        //Second Row

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 30, vCenter - 20, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 20, vCenter - 20, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 10, vCenter - 20, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 0, vCenter - 20, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        //Third Row
                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 40, vCenter - 10, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 30, vCenter - 10, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 20, vCenter - 10, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 10, vCenter - 10, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter, vCenter - 10, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter + 10, vCenter - 10, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        //Fourth Row
                    ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 45, vCenter - 0, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 30, vCenter - 0, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 20, vCenter - 0, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 10, vCenter - 0, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 0, vCenter - 0, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter + 15, vCenter - 0, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        //Fifth Row

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 40, vCenter + 10, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 30, vCenter + 10, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 20, vCenter + 10, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 10, vCenter + 10, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 0, vCenter + 10, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter + 10, vCenter + 10, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        //Sixth Row

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 30, vCenter + 20, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 20, vCenter + 20, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 10, vCenter + 20, 2, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter, vCenter + 20, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        //Last Row
                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 20, vCenter + 30, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();

                        ctxcircle.beginPath();
                        ctxcircle.arc(offleftcenter - 10, vCenter + 30, 1, 10 * Math.PI, false);
                        ctxcircle.fill();
                        ctxcircle.closePath();
                        ctxcircle.stroke();


                        if (canvascentergraphic.fill)
                           ctxcircle.fill();
                        if (canvascentergraphic.stroke)
                           ctxcircle.stroke();
                           ctxcircle.restore();
            }
         }
}
