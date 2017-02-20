import sys
import os
import dbus
from traceback import print_exc
from os.path import dirname
from adapt.intent import IntentBuilder
from mycroft.skills.core import MycroftSkill
from mycroft.util.log import getLogger

__author__ = 'aix'

LOGGER = getLogger(__name__)


class SendSMSPlasmaDesktopSkill(MycroftSkill):

    # The constructor of the skill, which calls MycroftSkill's constructor
    def __init__(self):
        super(SendSMSPlasmaDesktopSkill, self).__init__(name="SendSMSPlasmaDesktopSkill")
        
    # This method loads the files needed for the skill's functioning, and
    # creates and registers each intent that the skill uses
    def initialize(self):
        self.load_data_files(dirname(__file__))

        sendsms_plasma_desktopskill_intent = IntentBuilder("SendSMSKeywordIntent").\
            require("SendSMSPlasmaDesktopSkillKeyword").build()
        self.register_intent(sendsms_plasma_desktopskill_intent, self.handle_sendsms_plasma_desktopskill_intent)
        
    def handle_sendsms_plasma_desktopskill_intent(self, message):
        self.speak_dialog("sendSMS.state")
        os.system("python /opt/mycroft/skills/mycroft-sendSMS-plasma-desktop/sendSMS.py")
        

    def stop(self):
        pass

# The "create_skill()" method is used to create an instance of the skill.
# Note that it's outside the class itself.
def create_skill():
    return SendSMSPlasmaDesktopSkill()
