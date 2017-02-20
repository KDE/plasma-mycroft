import sys
import dbus
from traceback import print_exc
from os.path import dirname
from adapt.intent import IntentBuilder
from mycroft.skills.core import MycroftSkill
from mycroft.util.log import getLogger

__author__ = 'aix'

LOGGER = getLogger(__name__)


class KrunnerPlasmaDesktopSkill(MycroftSkill):

    # The constructor of the skill, which calls MycroftSkill's constructor
    def __init__(self):
        super(KrunnerPlasmaDesktopSkill, self).__init__(name="KrunnerPlasmaDesktopSkill")
        
    # This method loads the files needed for the skill's functioning, and
    # creates and registers each intent that the skill uses
    def initialize(self):
        self.load_data_files(dirname(__file__))

        krunner_plasma_desktopskill_intent = IntentBuilder("KrunnerKeywordIntent").\
            require("KrunnerPlasmaDesktopSkillKeyword").build()
        self.register_intent(krunner_plasma_desktopskill_intent, self.handle_krunner_plasma_desktopskill_intent)
        
        krunner_plasma_recentskill_intent = IntentBuilder("RecentFilesIntent").\
            require("RecentFileKeyword").build()
        self.register_intent(krunner_plasma_recentskill_intent, self.handle_krunner_plasma_recentskill_intent)

    def handle_krunner_plasma_desktopskill_intent(self, message):
        utterance = message.data.get('utterance').lower()
        utterance = utterance.replace(
                message.data.get('KrunnerPlasmaDesktopSkillKeyword'), '')
        searchString = utterance
        
        bus = dbus.SessionBus()
        remote_object = bus.get_object("org.kde.krunner","/App") 
        remote_object.query(searchString + ' ', dbus_interface = "org.kde.krunner.App")
        
        self.speak_dialog("krunner.search", data={'Query': searchString})

    
    def handle_krunner_plasma_recentskill_intent(self, message):        
        bus = dbus.SessionBus()
        remote_object = bus.get_object("org.kde.krunner","/App") 
        remote_object.query('recent' + ' ', dbus_interface = "org.kde.krunner.App")
        
        self.speak_dialog("krunner.recent")
    
    def stop(self):
        pass

# The "create_skill()" method is used to create an instance of the skill.
# Note that it's outside the class itself.
def create_skill():
    return KrunnerPlasmaDesktopSkill()
