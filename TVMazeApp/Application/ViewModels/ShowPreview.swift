//
//  ShowPreview.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 11/3/25.
//

import SwiftUI

@Observable()
class ShowPreview: Identifiable {
    var id: Int
    var imageUrl: String
    var name: String
    var summary: String
    var rating: Float?
    
    init(from show: Show) {
        id = show.id
        imageUrl = show.image?.medium ?? show.image?.original ?? ""
        name = show.name ?? "N/A"
        let newSummary = show.summary ?? "N/A"
        summary = newSummary.trimmedTo(wordCount: 80) ?? newSummary
        rating = show.rating.average
    }
}

extension ShowPreview: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: ShowPreview, rhs: ShowPreview) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
