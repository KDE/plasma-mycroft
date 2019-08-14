/* Copyright 2019 Aditya Mehra <aix.m@outlook.com>                            

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

ListModel {
    id: skillshintmodel
    ListElement {
        Pic: "../images/alarm.png"
        Skill: "Alarm"
        CommandList: [
            ListElement { Commands: "Hey Mycroft, Set an alarm for 9 pm" },
            ListElement { Commands: "Hey Mycroft, Cancel alarm" }
        ]
    }

    ListElement {
        Pic: "../images/dateandtime.png"
        Skill: "Date & Time"
        CommandList: [
            ListElement { Commands: "Hey Mycroft, What is the current time" },
            ListElement { Commands: "Hey Mycroft, What is the date today" }
        ]
    }

    ListElement {
        Pic: "../images/desktop.png"
        Skill: "Desktop"
        CommandList: [
            ListElement { Commands: "Hey Mycroft, Open firefox"},
            ListElement { Commands: "Hey Mycroft, Open konsole"}
        ]
    }

    ListElement {
        Pic: "../images/joke.png"
        Skill: "Joke"
        CommandList: [
            ListElement {Commands: "Hey Mycroft, Tell me a joke"},
            ListElement {Commands: "Hey Mycroft, Sing for me"}
        ]
    }

    ListElement {
        Pic: "../images/spell.png"
        Skill: "Spell"
        CommandList: [
            ListElement {Commands: "Hey Mycroft, Spell hello"},
            ListElement {Commands: "Hey Mycroft, Spell mycroft"}
        ]
    }
    
    ListElement {
        Pic: "../images/productivity.png"
        Skill: "Productivity"
        CommandList: [
            ListElement {Commands: "Hey Mycroft, What is the stock price of nasdaq"},
            ListElement {Commands: "Hey Mycroft, What is the current price of oil"}
        ]
    }

    ListElement {
        Pic: "../images/wikip.png"
        Skill: "WiKi"
        CommandList: [
            ListElement {Commands: "Hey Mycroft, What is the distance to the moon"},
            ListElement {Commands: "Hey Mycroft, What is relativity"}
        ]
    }

    ListElement {
        Pic: "../images/wolfram.png"
        Skill: "Wolfram Alpha"
        CommandList: [
            ListElement {Commands: "Hey Mycroft, What is PI to 10 digits"},
            ListElement {Commands: "Hey Mycroft, What is 2+2"}
        ]
    }

    ListElement {
        Pic: "../images/weather.png"
        Skill: "Weather"
        CommandList: [
            ListElement {Commands: "Hey Mycroft, What is the current weather"},
            ListElement {Commands: "Hey Mycroft, Current weather in Tokyo"}
        ]
    }
} 
