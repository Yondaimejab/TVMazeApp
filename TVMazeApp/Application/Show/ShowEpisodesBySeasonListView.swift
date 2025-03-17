//
//  ShowEpisodesBySeasonListView.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 16/3/25.
//

import SwiftUI

struct ShowEpisodesBySeasonListView: View {
    var showInformation: ShowInformation
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Episodes")
                .font(.title2)
                .fontWeight(.bold)
                .padding([.leading, .vertical])
            let items = showInformation.seasonEpisodes.keys.sorted(by: { $0 < $1 })
            ForEach(Array(items), id: \.self) { key in
                Text("Season #\(key)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding([.leading, .vertical])
                if let elements = showInformation.seasonEpisodes[key] {
                    ShowEpisodesBySeasonListViewItem(
                        episodes: elements,
                        seasonEpisodes: elements.count
                    )
                }
            }
        }
    }
}
