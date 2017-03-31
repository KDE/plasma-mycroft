import sys
import dbus
import glib
import os
import psutil
from traceback import print_exc
from os.path import dirname
from adapt.intent import IntentBuilder
from mycroft.skills.core import MycroftSkill
from mycroft.util.log import getLogger

__author__ = 'aix'

LOGGER = getLogger(__name__)

class AmarokMusicPlayerSkill(MycroftSkill):

    # The constructor of the skill, which calls MycroftSkill's constructor
    def __init__(self):
        super(AmarokMusicPlayerSkill, self).__init__(name="AmarokMusicPlayerSkill")
        
    # This method loads the files needed for the skill's functioning, and
    # creates and registers each intent that the skill uses
    def initialize(self):
        self.load_data_files(dirname(__file__))

        internals_amarok_play_skill_intent = IntentBuilder("AmarokPlayKeywordIntent").\
            require("AmarokPlayKeyword").build()
        self.register_intent(internals_amarok_play_skill_intent, self.handle_internals_amarok_play_skill_intent)
        
        internals_amarok_stop_skill_intent = IntentBuilder("AmarokStopKeywordIntent").\
            require("AmarokStopKeyword").build()
        self.register_intent(internals_amarok_stop_skill_intent, self.handle_internals_amarok_stop_skill_intent)
        
        internals_amarok_next_skill_intent = IntentBuilder("AmarokNextKeywordIntent").\
            require("AmarokNextKeyword").build()
        self.register_intent(internals_amarok_next_skill_intent, self.handle_internals_amarok_next_skill_intent)

        internals_amarok_previous_skill_intent = IntentBuilder("AmarokPreviousKeywordIntent").\
            require("AmarokPreviousKeyword").build()
        self.register_intent(internals_amarok_previous_skill_intent, self.handle_internals_amarok_previous_skill_intent)
        
        internals_amarok_pause_skill_intent = IntentBuilder("AmarokPauseKeywordIntent").\
            require("AmarokPauseKeyword").build()
        self.register_intent(internals_amarok_pause_skill_intent, self.handle_internals_amarok_pause_skill_intent)


    def handle_internals_amarok_play_skill_intent(self, message):    
	self.speak_dialog("amarok.play")
        amarokRunning = False   

        for proc in psutil.process_iter():
            pinfo = proc.as_dict(attrs=['pid', 'name'])    
            if pinfo['name'] == 'amarok':
                amarokRunning = True
    
        if amarokRunning:
            #print('yes')
	    def runplay():
       		 bus = dbus.SessionBus()
        	 remote_object = bus.get_object("org.mpris.MediaPlayer2.amarok","/org/mpris/MediaPlayer2")
        	 remote_object.Play(dbus_interface = "org.mpris.MediaPlayer2.Player")	
	    runplay()
        
	else:
       	   def runprocandplay():
           	os.system("amarok")
           	bus = dbus.SessionBus()
           	remote_object = bus.get_object("org.mpris.MediaPlayer2.amarok","/org/mpris/MediaPlayer2")
           	remote_object.Play(dbus_interface = "org.mpris.MediaPlayer2.Player")
           runprocandplay()
   
    def handle_internals_amarok_stop_skill_intent(self, message):        
        bus = dbus.SessionBus()
        remote_object = bus.get_object("org.mpris.MediaPlayer2.amarok","/org/mpris/MediaPlayer2") 
        remote_object.Stop(dbus_interface = "org.mpris.MediaPlayer2.Player")
        
        self.speak_dialog("amarok.stop")
    
    def handle_internals_amarok_next_skill_intent(self, message):
        bus = dbus.SessionBus()
        remote_object = bus.get_object("org.mpris.MediaPlayer2.amarok","/org/mpris/MediaPlayer2") 
        remote_object.Next(dbus_interface = "org.mpris.MediaPlayer2.Player")
        
        self.speak_dialog("amarok.next")
        
    def handle_internals_amarok_previous_skill_intent(self, message):
        
        bus = dbus.SessionBus()
        remote_object = bus.get_object("org.mpris.MediaPlayer2.amarok","/org/mpris/MediaPlayer2") 
        remote_object.Previous(dbus_interface = "org.mpris.MediaPlayer2.Player")
        
        self.speak_dialog("amarok.previous")     

    def handle_internals_amarok_pause_skill_intent(self, message):
        
        bus = dbus.SessionBus()
        remote_object = bus.get_object("org.mpris.MediaPlayer2.amarok","/org/mpris/MediaPlayer2") 
        remote_object.Pause(dbus_interface = "org.mpris.MediaPlayer2.Player")
        
        self.speak_dialog("amarok.pause")     
        
    def stop(self):
        pass

# The "create_skill()" method is used to create an instance of the skill.
# Note that it's outside the class itself.
def create_skill():
    return AmarokMusicPlayerSkill()
