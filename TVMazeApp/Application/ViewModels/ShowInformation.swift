//
//  ShowInformation.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 15/3/25.
//

import SwiftUI

@Observable()
class ShowInformation {
    var name: String
    var image: String
    var poster: String
    var schedule: Schedule
    var genres: [String]
    var summary: String
    var seasonEpisodes: [Int: [ShowEpisodeViewModel]]
    
    init(
        name: String,
        image: String,
        poster: String,
        schedule: Schedule,
        genres: [String],
        summary: String
    ) {
        self.name = name
        self.image = image
        self.poster = poster
        self.schedule = schedule
        self.genres = genres
        self.summary = summary
        self.seasonEpisodes = [:]
    }
    
    init(from show: Show, episodes: [ShowEpisode]) {
        name = show.name ?? ""
        image = show.image?.medium ?? ""
        poster = show.image?.original ?? ""
        schedule = .init(from: show.schedule)
        genres = show.genres ?? []
        summary = show.summary ?? ""
        seasonEpisodes = [:]
        episodes.forEach { episode in
            if seasonEpisodes[episode.season] == nil {
                seasonEpisodes[episode.season] = [.init(from: episode)]
            } else {
                seasonEpisodes[episode.season]?.append(
                    .init(from: episode)
                )
            }
        }
    }
}
