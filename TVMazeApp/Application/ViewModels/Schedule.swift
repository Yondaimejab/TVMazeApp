//
//  Schedule.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 16/3/25.
//

import SwiftUI

@Observable()
class Schedule {
    var time: String
    var days: [String]
    
    init(time: String, days: [String]) {
        self.time = time
        self.days = days
    }
    
    init(from schedule: Show.Schedule?) {
        time = schedule?.time ?? ""
        days = schedule?.days ?? []
    }
}

extension Schedule {
    static var mock: Schedule {
        Schedule(
            time: "22:00",
            days: [
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Satuday",
                "Sunday"
            ]
        )
    }
}
