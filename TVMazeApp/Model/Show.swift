//
//  Show.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 11/3/25.
//

struct Show: Codable {
    struct Rating: Codable {
        var average: Float?
    }
    
    struct Images: Codable {
        var medium: String?
        var original: String?
    }
    
    struct Schedule: Codable {
        var time: String
        var days: [String]
        
        init(time: String, days: [String]) {
            self.time = time
            self.days = days
        }
    }
    
    var id: Int
    var url: String?
    var name: String?
    var summary: String?
    var rating: Show.Rating
    var image: Images?
    var genres: [String]?
    var schedule: Schedule?
}

struct ShowSearchResult: Codable {
    var score: Double?
    var show: Show
}
