import sys
import dbus
import glib
from traceback import print_exc
from os.path import dirname
from adapt.intent import IntentBuilder
from mycroft.skills.core import MycroftSkill
from mycroft.util.log import getLogger

__author__ = 'aix'
catchInput = " "

LOGGER = getLogger(__name__)

class ActivitiesPlasmaDesktopSkill(MycroftSkill):

    # The constructor of the skill, which calls MycroftSkill's constructor
    def __init__(self):
        super(ActivitiesPlasmaDesktopSkill, self).__init__(name="ActivitiesPlasmaDesktopSkill")
        
    # This method loads the files needed for the skill's functioning, and
    # creates and registers each intent that the skill uses
    def initialize(self):
        self.load_data_files(dirname(__file__))

        activities_create_plasma_skill_intent = IntentBuilder("ActivitiesKeywordIntent").\
            require("ActivitiesCreateKeyword").build()
        self.register_intent(activities_create_plasma_skill_intent, self.handle_activities_create_plasma_skill_intent)
        
        activities_show_plasma_skill_intent = IntentBuilder("ShowActivitiesIntent").\
            require("ActivitiesShowKeyword").build()
        self.register_intent(activities_show_plasma_skill_intent, self.handle_activities_show_plasma_skill_intent)
        
        activities_remove_plasma_skill_intent = IntentBuilder("RemoveActivitiesIntent").\
            require("ActivitiesRemoveKeyword").build()
        self.register_intent(activities_remove_plasma_skill_intent, self.handle_activities_remove_plasma_skill_intent)

        activities_stop_plasma_skill_intent = IntentBuilder("StopActivitiesIntent").\
            require("ActivitiesStopKeyword").build()
        self.register_intent(activities_stop_plasma_skill_intent, self.handle_activities_stop_plasma_skill_intent)
        
        activities_switch_plasma_skill_intent = IntentBuilder("SwitchActivitiesIntent").\
            require("ActivitiesSwitchKeyword").build()
        self.register_intent(activities_switch_plasma_skill_intent, self.handle_activities_switch_plasma_skill_intent)

    def handle_activities_create_plasma_skill_intent(self, message):
        utterance = message.data.get('utterance').lower()
        utterance = utterance.replace(
                message.data.get('ActivitiesCreateKeyword'), '')
        searchString = utterance
        
        bus = dbus.SessionBus()
        remote_object = bus.get_object("org.kde.ActivityManager","/ActivityManager/Activities") 
        remote_object.AddActivity(searchString, dbus_interface = "org.kde.ActivityManager.Activities")
        remote_object2 = bus.get_object("org.kde.plasmashell", "/PlasmaShell")
        remote_object2.toggleActivityManager(dbus_interface = "org.kde.PlasmaShell")
 
        self.speak_dialog("activities.create", data={'CreateActivityName': searchString})
    
    def handle_activities_show_plasma_skill_intent(self, message):        
        bus = dbus.SessionBus()
        remote_object2 = bus.get_object("org.kde.plasmashell", "/PlasmaShell")
        remote_object2.toggleActivityManager(dbus_interface = "org.kde.PlasmaShell")
        
        self.speak_dialog("activities.show")
    
    def handle_activities_remove_plasma_skill_intent(self, message):
        searchString = "Not Implemented WIP"
        self.speak_dialog("activities.remove", data={'RemoveActivityName': searchString})
        
    def handle_activities_stop_plasma_skill_intent(self, message):
        searchString = "Not Implemented WIP"
        self.speak_dialog("activities.stop", data={'StopActivityName': searchString})    
        
    def handle_activities_switch_plasma_skill_intent(self, message):
        searchString = "Not Implemented WIP"
        self.speak_dialog("activities.switch", data={'SwitchActivityName': searchString})     
        
    def stop(self):
        pass

# The "create_skill()" method is used to create an instance of the skill.
# Note that it's outside the class itself.
def create_skill():
    return ActivitiesPlasmaDesktopSkill()
