//
//  EpisodeDetailsView.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 16/3/25.
//

import SwiftUI

struct EpisodeDetailsView: View {
    var episode: ShowEpisodeViewModel
    var seasonEpisodes: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(episode.name)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Text("\(episode.number) / \(seasonEpisodes)")
                    .foregroundStyle(Color.white)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue)
                    )
            }
            .padding(.horizontal)
            if let url = URL(string: episode.posterURL) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .frame(maxHeight: 300)
                    } else if phase.error != nil {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray)
                            .frame(maxHeight: 300)
                    } else {
                        ProgressView()
                    }
                }
                .padding(.horizontal)
            }
            VStack(alignment: .trailing) {
                Text("Season \(episode.season)")
                    .padding(.horizontal)
                    .padding(.vertical, 10)
            }
            .padding(.horizontal)
            Text(episode.summary)
                .font(.headline)
                .fontWeight(.regular)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
                .padding(.horizontal)
            Spacer()
            
        }
    }
}
