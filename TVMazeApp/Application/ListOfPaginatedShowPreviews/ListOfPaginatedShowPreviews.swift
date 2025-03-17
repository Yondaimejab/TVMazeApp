//
//  ListOfPaginatedShowPreviews.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 11/3/25.
//

import SwiftUI

struct ListOfPaginatedShowPreviews: View {
    @State private var showPreviews: [ShowPreview] = []
    @State private var searchResults: [ShowPreview] = []
    @State private var currentPage: Int = 1
    @State private var lastPageLoaded = false
    @State private var isFetchingContent = false
    @State private var searchText: String = ""
    @State private var shouldDisplaySpinner: Bool = false
    
    @EnvironmentObject private var service: BaseTVMazeClient
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .padding(.horizontal, 4)
                        TextField("Search Shows", text: $searchText)
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
                    .onChange(of: searchText, {
                        guard searchText.count >= 3 else {
                            searchResults = []
                            return
                        }
                        Task { await searchElements() }
                    })
                    if searchText.isEmpty {
                        HStack {
                            Text("List Of Shows From Maze TV")
                                .font(.title)
                                .padding(.leading)
                            Spacer()
                        }
                        ShowPreviewListView(
                            showPreviews: $showPreviews,
                            isFetchingContent: $isFetchingContent,
                            action: {
                            Task {
                                await loadNextPage()
                            }
                        })
                    } else {
                        HStack {
                            Text("Shows Search Result")
                                .font(.title)
                                .padding(.leading)
                            Spacer()
                        }
                        ShowPreviewListView(
                            showPreviews: $searchResults,
                            isFetchingContent: $isFetchingContent
                        )
                    }
                    Spacer()
                }
                SpinnerView()
                    .opacity(shouldDisplaySpinner ? 1.0 : .zero)
                    .animation(.easeInOut, value: shouldDisplaySpinner)
            }
            .task {
                isFetchingContent = true
                await loadNextPage()
            }
            .navigationTitle("Maze TV APP")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
    
    private func didFinishFetchWith(_ result: Result<[Show], RequestError>) {
        switch result {
        case .success(let shows):
            showPreviews.append(contentsOf: shows.map { ShowPreview(from: $0) })
        case .failure(let error):
            switch error {
            case .elementsLimitReached:
                lastPageLoaded = true
            default:
                print("default")
                // TODO: - Add an error message to display
            }
        }
        shouldDisplaySpinner = false
        isFetchingContent = false
    }
    
    private func loadNextPage() async {
        guard !lastPageLoaded else { return }
        shouldDisplaySpinner = true
        currentPage += 1
        let result = await service.fetchPaginatedListOfShowPreviews(page: currentPage)
        Task { @MainActor in
            self.didFinishFetchWith(result)
        }
    }
    
    private func searchElements() async {
        shouldDisplaySpinner = true
        let result = await service.fetchShowsInSearchOf(query: searchText)
        Task { @MainActor in
            self.didFinishSearchingWith(result)
        }
    }
    
    private func didFinishSearchingWith(_ result: Result<[ShowSearchResult], RequestError>) {
        switch result {
        case .success(let shows):
            searchResults = shows.map { ShowPreview(from: $0.show) }
        case .failure:
            searchResults = []
        }
        isFetchingContent = false
        shouldDisplaySpinner = false
    }
}

#Preview {
    ListOfPaginatedShowPreviews()
}
