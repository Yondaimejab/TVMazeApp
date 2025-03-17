//
//  BaseTVMazeClient.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 11/3/25.
//

import NetworkingExtension
import Foundation
import Combine

class BaseTVMazeClient: ObservableObject {
    static let shared = BaseTVMazeClient()
    
    private static let baseURL = "https://api.tvmaze.com/"
    private func buildBaseTVMazeRoute(path: String = "") -> Router {
        Router(baseURL: Self.baseURL, path: path)
    }
    
    private init() { }
    
    func fetchPaginatedListOfShowPreviews(page: Int = 1) async -> Result<[Show], RequestError> {
        let router = buildBaseTVMazeRoute(path: "shows")
        let contents = BaseRequestContents(
            method: "GET",
            params: ["page": page],
            headers: [:]
        )
        guard let request = BaseRequestBuilder(router: router, contents: contents).request else {
            return .failure(.couldNotBuildRequest)
        }
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            return .failure(.requestFailed)
        }
        guard let showPreviews = try? JSONDecoder().decode([Show].self, from: data) else {
            return .failure(.decodingFailed)
        }
        guard !showPreviews.isEmpty else { return .failure(.elementsLimitReached) }
        return .success(showPreviews)
    }
    
    func fetchShowsInSearchOf(query: String) async -> Result<[ShowSearchResult], RequestError> {
        let router = buildBaseTVMazeRoute(path: "search/shows")
        let contents = BaseRequestContents(
            method: "GET",
            params: ["q": query],
            headers: [:]
        )
        guard let request = BaseRequestBuilder(router: router, contents: contents).request else {
            return .failure(.couldNotBuildRequest)
        }
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            return .failure(.requestFailed)
        }
        do {
            let showPreviews = try JSONDecoder().decode([ShowSearchResult].self, from: data)
            guard !showPreviews.isEmpty else { return .failure(.elementsLimitReached) }
            return .success(showPreviews)
        } catch {
            print(error.localizedDescription)
            return .failure(.decodingFailed)
        }
    }
    
    func fetchDetailsForShow(
        identifiedBy identifier: Int
    ) async -> Result<Show, RequestError> {
        let router = buildBaseTVMazeRoute(path: "shows/\(identifier)")
        let contents = BaseRequestContents.buildEmptyContentForGetRequest()
        guard let request = BaseRequestBuilder(router: router, contents: contents).request else {
            return .failure(.couldNotBuildRequest)
        }
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            return .failure(.requestFailed)
        }
        do {
            let showDetails = try JSONDecoder().decode(Show.self, from: data)
            return .success(showDetails)
        } catch {
            print(error.localizedDescription)
            return .failure(.decodingFailed)
        }
    }
    
    func fetchEpisodesForShow(
        identifiedBy identifier: Int
    ) async -> Result<[ShowEpisode], RequestError> {
        let router = buildBaseTVMazeRoute(path: "shows/\(identifier)/episodes")
        let contents = BaseRequestContents.buildEmptyContentForGetRequest()
        guard let request = BaseRequestBuilder(router: router, contents: contents).request else {
            return .failure(.couldNotBuildRequest)
        }
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            return .failure(.requestFailed)
        }
        do {
            var showDetails = try JSONDecoder().decode([ShowEpisode].self, from: data)
            showDetails.customSort()
            return .success(showDetails)
        } catch {
            print(error.localizedDescription)
            return .failure(.decodingFailed)
        }
    }
}
