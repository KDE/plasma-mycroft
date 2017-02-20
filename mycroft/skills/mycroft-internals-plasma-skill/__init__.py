import sys
import dbus
import glib
from traceback import print_exc
from os.path import dirname
from adapt.intent import IntentBuilder
from mycroft.skills.core import MycroftSkill
from mycroft.util.log import getLogger

__author__ = 'aix'

LOGGER = getLogger(__name__)

class InternalsPlasmaDesktopSkill(MycroftSkill):

    # The constructor of the skill, which calls MycroftSkill's constructor
    def __init__(self):
        super(InternalsPlasmaDesktopSkill, self).__init__(name="InternalsPlasmaDesktopSkill")
        
    # This method loads the files needed for the skill's functioning, and
    # creates and registers each intent that the skill uses
    def initialize(self):
        self.load_data_files(dirname(__file__))

        internals_switchuser_plasma_skill_intent = IntentBuilder("SwitchUserKeywordIntent").\
            require("InternalSwitchUserKeyword").build()
        self.register_intent(internals_switchuser_plasma_skill_intent, self.handle_internals_switchuser_plasma_skill_intent)
        
        internals_lock_plasma_skill_intent = IntentBuilder("LockKeywordIntent").\
            require("InternalLockDesktopKeyword").build()
        self.register_intent(internals_lock_plasma_skill_intent, self.handle_internals_lock_plasma_skill_intent)
        
        internals_logout_plasma_skill_intent = IntentBuilder("LogoutKeywordIntent").\
            require("InternalLogoutDesktopKeyword").build()
        self.register_intent(internals_logout_plasma_skill_intent, self.handle_internals_logout_plasma_skill_intent)

    def handle_internals_switchuser_plasma_skill_intent(self, message):
        
        bus = dbus.SessionBus()
        remote_object = bus.get_object("org.kde.ksmserver","/KSMServer") 
        remote_object.openSwitchUserDialog(dbus_interface = "org.kde.KSMServerInterface")
        
        self.speak_dialog("internals.switchuser")
    
    def handle_internals_logout_plasma_skill_intent(self, message):        
        bus = dbus.SessionBus()
        remote_object = bus.get_object("org.kde.ksmserver","/KSMServer") 
        remote_object.logout(1, 0, 0, dbus_interface = "org.kde.KSMServerInterface")
        
        self.speak_dialog("internals.logout")
    
    def handle_internals_lock_plasma_skill_intent(self, message):
        bus = dbus.SessionBus()
        remote_object = bus.get_object("org.kde.ksmserver","/ScreenSaver") 
        remote_object.Lock(dbus_interface = "org.freedesktop.ScreenSaver")
        
        self.speak_dialog("internals.lock")
        
    def stop(self):
        pass

# The "create_skill()" method is used to create an instance of the skill.
# Note that it's outside the class itself.
def create_skill():
    return InternalsPlasmaDesktopSkill()
