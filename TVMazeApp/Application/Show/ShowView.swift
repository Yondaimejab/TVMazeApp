//
//  ShowView.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 15/3/25.
//

import SwiftUI

struct ShowView: View {
    var showIdentifier: Int = 1
    @State private var isLoading: Bool = false
    @State private var showInformation: ShowInformation?
    @State private var shouldDisplayError: Bool = false
    @EnvironmentObject private var service: BaseTVMazeClient
    
    var body: some View {
        ZStack {
            if let showInformation {
                if let url = URL(string: showInformation.poster) {
                    VStack {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(maxHeight: 300)
                            } else if phase.error != nil {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray)
                            } else {
                                ProgressView()
                            }
                        }
                        Spacer()
                    }
                }
                VStack(alignment: .leading) {
                    Text(showInformation.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 300)
                        .padding(.leading)
                    ScrollView(.vertical) {
                        VStack {
                            Text(showInformation.summary)
                                .font(.headline)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal)
                            ScheduleDisplayView(schedule: showInformation.schedule)
                                .padding(.top)
                            Text("Genres")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding([.horizontal, .top])
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(showInformation.genres, id: \.self) { genre in
                                        Text(genre)
                                            .foregroundStyle(Color.white)
                                            .padding(.horizontal)
                                            .padding(.vertical, 10)
                                            .background( RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.blue)
                                            )
                                    }
                                }
                            }
                            .frame(maxHeight: 50)
                            .padding(.leading)
                            ShowEpisodesBySeasonListView(showInformation: showInformation)
                        }
                    }
                    Spacer()
                }
                .refreshable {
                    Task {
                        await loadShowInformation()
                    }
                }
            }
            if isLoading {
                SpinnerView()
            }
            if shouldDisplayError {
                ErrorMessageDisplayView(shouldDisplayError: $shouldDisplayError)
            }
        }
        .task {
            await loadShowInformation()
        }
    }
    
    private func loadShowInformation() async {
        Task { @MainActor in
            isLoading = true
        }
        let showDetailsResult = await service.fetchDetailsForShow(identifiedBy: showIdentifier)
        let showEpisodesResult = await service.fetchEpisodesForShow(identifiedBy: showIdentifier)
        guard case .success(let show) = showDetailsResult,
              case .success(let listOfEpisodes) = showEpisodesResult else {
            Task { @MainActor in
                isLoading = false
                shouldDisplayError = true
            }
            return
        }
        Task { @MainActor in
            isLoading = false
            self.showInformation = ShowInformation(from: show, episodes: listOfEpisodes)
        }
    }
}

#Preview {
    ShowView(showIdentifier: 1)
        .environmentObject(BaseTVMazeClient.shared)
}
