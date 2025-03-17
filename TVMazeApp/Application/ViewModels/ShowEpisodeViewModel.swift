//
//  ShowEpisodeViewModel.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 16/3/25.
//
import SwiftUI

@Observable()
class ShowEpisodeViewModel {
    var id: Int
    var name: String
    var number: Int
    var season: Int
    var imageURL: String
    var posterURL: String
    var summary: String
    
    init(
        id: Int,
        name: String,
        number: Int,
        season: Int,
        imageUrl: String,
        posterURL: String,
        summary: String
    ) {
        self.id = id
        self.name = name
        self.number = number
        self.season = season
        self.imageURL = imageUrl
        self.posterURL = posterURL
        self.summary = summary
    }
    
    init(from episode: ShowEpisode) {
        self.id = episode.id
        self.name = episode.name
        self.number = episode.number
        self.season = episode.season
        self.imageURL = episode.image?.medium ?? ""
        self.posterURL = episode.image?.original ?? ""
        self.summary = episode.summary
    }
}
