from PyQt5 import QtCore, QtGui, QtWidgets
import sys
import subprocess
import argparse

num = " "
smsg = " "
devid = " "

def getDeviceID():
    dres = subprocess.check_output(('kdeconnect-cli', '-l', '--id-only'))                               
    msgBody(dres)
    
def msgBody(devid):
         devnum = devid.strip()
         res = subprocess.call(('kdeconnect-cli', '--device', devnum, '--destination', num, '--send-sms', smsg)) 
         #print devnum
         #print num 
         #print smsg
         
class Ui_MainWindow(object):
    
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(429, 112)
        self.centralWidget = QtWidgets.QWidget(MainWindow)
        self.centralWidget.setObjectName("centralWidget")
        self.label = QtWidgets.QLabel(self.centralWidget)
        self.label.setGeometry(QtCore.QRect(0, 10, 121, 16))
        self.label.setObjectName("label")
        self.lineEdit = QtWidgets.QLineEdit(self.centralWidget)
        self.lineEdit.setGeometry(QtCore.QRect(110, 10, 201, 21))
        self.lineEdit.setObjectName("lineEdit")
        self.my_regex = QtCore.QRegExp("([0-9]|[\-+#])+")
        self.validator = QtGui.QRegExpValidator(self.my_regex)
        self.lineEdit.setValidator(self.validator)
        self.label_2 = QtWidgets.QLabel(self.centralWidget)
        self.label_2.setGeometry(QtCore.QRect(0, 60, 64, 15))
        self.label_2.setObjectName("label_2")
        self.plainTextEdit = QtWidgets.QPlainTextEdit(self.centralWidget)
        self.plainTextEdit.setGeometry(QtCore.QRect(60, 40, 251, 61))
        #self.plainTextEdit.setFrameShape(QtWidgets.QFrame.Box)
        self.plainTextEdit.setObjectName("plainTextEdit")
        self.label_3 = QtWidgets.QLabel(self.centralWidget)
        self.label_3.setGeometry(QtCore.QRect(0, 95, 121, 16))
        self.label_3.setObjectName("label_3")
        self.pushButton = QtWidgets.QPushButton(self.centralWidget)
        self.pushButton.setGeometry(QtCore.QRect(330, 20, 91, 31))
        self.pushButton.setObjectName("pushButton")
        self.pushButton_2 = QtWidgets.QPushButton(self.centralWidget)
        self.pushButton_2.setGeometry(QtCore.QRect(330, 60, 91, 31))
        self.pushButton_2.setObjectName("pushButton_2")
        #MainWindow.setCentralWidget(self.centralWidget)

        self.lineEdit.textChanged.connect(self.number_edit_text_changed)
        self.plainTextEdit.textChanged.connect(self.msg_edit_text_changed)
        self.plainTextEdit.textChanged.connect(self.updateCounter)
        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)
        self.pushButton.clicked.connect(getDeviceID)
        self.pushButton_2.clicked.connect(self.plainTextEdit.clear)
        
    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "Send SMS"))
        self.label.setText(_translate("MainWindow", "Phone Number"))
        self.lineEdit.setToolTip(_translate("MainWindow", "Phone Number"))
        self.lineEdit.setPlaceholderText(_translate("MainWindow", "Contact Phone Number"))
        self.label_2.setText(_translate("MainWindow", "Message"))
        self.plainTextEdit.setPlaceholderText(_translate("MainWindow", "Message"))
        self.pushButton.setText(_translate("MainWindow", "Send"))
        self.pushButton_2.setText(_translate("MainWindow", "Clear"))
        
    def number_edit_text_changed(self, text):
        global num
        num = text
        
    def msg_edit_text_changed(self):
        global smsg
        smsg = self.plainTextEdit.toPlainText()
    
    def updateCounter(self):
        strlen = len(self.plainTextEdit.toPlainText())
        countr = str(strlen)
        self.label_3.setText(countr)
        
if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QDialog()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())

