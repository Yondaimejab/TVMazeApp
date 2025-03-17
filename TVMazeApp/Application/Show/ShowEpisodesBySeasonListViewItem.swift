//
//  ShowEpisodesBySeasonListViewItem.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 16/3/25.
//

import SwiftUI

struct ShowEpisodesBySeasonListViewItem: View {
    var episodes: [ShowEpisodeViewModel]
    var seasonEpisodes: Int
    @State private var shouldNavigate: Bool = false
    @State private var selectedEpisode: ShowEpisodeViewModel?
    
    var body: some View {
        ForEach(episodes, id: \.id) { element in
            HStack {
                if let url = URL(string: element.imageURL) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: 48, height: 48)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else if phase.error != nil {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray)
                                .frame(width: 48, height: 48)
                        } else {
                            ProgressView()
                        }
                    }
                    .padding(.leading)
                }
                Text(element.name)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding([.leading, .vertical])
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 24, height: 32)
            }
            .padding(5)
            .padding(.trailing)
            .background(Color.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            .onTapGesture {
                selectedEpisode = element
                shouldNavigate = true
            }
        }
        .navigationDestination(isPresented: $shouldNavigate, destination: {
            if let selectedEpisode {
                EpisodeDetailsView(episode: selectedEpisode, seasonEpisodes: seasonEpisodes)
            }
        })
    }
}
