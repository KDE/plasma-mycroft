import QtQuick 2.0

ListModel {
    id: skillshintmodel
    ListElement {
        Pic: "../images/alarm.png"
        Skill: "Alarm"
        CommandList: [
         ListElement { Commands: "Hey Mycroft, Set alarm for %time" },
         ListElement { Commands: "Hey Mycroft, Set alarm for %time on %date" }
        ]
    }

    ListElement {
        Pic: "../images/dateandtime.png"
        Skill: "Date & Time"
        CommandList: [
        ListElement { Commands: "Hey Mycroft, What is the current time" },
        ListElement { Commands: "Hey Mycroft, Current date in London" }
        ]
    }

    ListElement {
        Pic: "../images/desktop.png"
        Skill: "Desktop"
        CommandList: [
        ListElement { Commands: "Hey Mycroft, Open Firefox"},
        ListElement { Commands: "Hey Mycroft, Open Konsole"}
        ]
    }

    ListElement {
        Pic: "../images/joke.png"
        Skill: "Joke"
        CommandList: [
        ListElement {Commands: "Hey Mycroft, Tell me a joke"},
        ListElement {Commands: "Hey Mycroft, Meaning of life"}
        ]
    }

    ListElement {
        Pic: "../images/spell.png"
        Skill: "Spell"
        CommandList: [
        ListElement {Commands: "Hey Mycroft, Spell Hello"},
        ListElement {Commands: "Hey Mycroft, Spell Mycroft"}
        ]
    }

    ListElement {
        Pic: "../images/wikip.png"
        Skill: "WiKi"
        CommandList: [
        ListElement {Commands: "Hey Mycroft, Wiki the Moon"},
        ListElement {Commands: "Hey Mycroft, Define Relativity"}
        ]
    }

    ListElement {
        Pic: "../images/wolfram.png"
        Skill: "Wolfram Alpha"
        CommandList: [
        ListElement {Commands: "Hey Mycroft, Calculate the Pi"},
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
