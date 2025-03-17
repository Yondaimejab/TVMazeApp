//
//  ShowEpisode.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 16/3/25.
//

struct ShowEpisode: Codable {
    var id: Int
    var name: String
    var url: String
    var image: Show.Images?
    var summary: String
    var season: Int
    var number: Int
    var type: String
    var rating: Show.Rating?
}

extension Array where Element == ShowEpisode {
    mutating func customSort() {
        self = sorted(by: { lhs, rhs in
            lhs.season < rhs.season && lhs.number < rhs.number
        })
    }
}
