//
//  NetworkingTests.swift
//  TVMazeAppTests
//
//  Created by Joel Alcantara on 16/3/25.
//

import XCTest
@testable import TVMazeApp

final class NetworkingTests: XCTestCase {
    var sut: BaseTVMazeClient!
    
    override func setUpWithError() throws {
        setUp()
        sut = BaseTVMazeClient.shared
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testWhenBuildingEmptyRequestContentMethodIsGet() {
        let contents = BaseRequestContents.buildEmptyContentForGetRequest()
        XCTAssertEqual(contents.method, "GET")
    }
    
    func testWhenRequestingShows() {
        let expectation = expectation(description: "listShowsRequest")
        Task {
            let result = await sut.fetchPaginatedListOfShowPreviews()
            switch result {
            case .success(let shows):
                XCTAssertFalse(shows.isEmpty)
            case .failure:
                XCTFail("could not reach service.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testWhenRequestingSearchForShow() {
        let expectation = expectation(description: "searchShowsRequest")
        Task {
            let result = await sut.fetchShowsInSearchOf(query: "Under")
            switch result {
            case .success(let shows):
                XCTAssertFalse(shows.isEmpty)
            case .failure:
                XCTFail("could not reach service.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    
    func testWhenRequestingForEspecificShow() {
        let expectation = expectation(description: "listShowsRequest")
        Task {
            let result = await sut.fetchDetailsForShow(identifiedBy: 1)
            switch result {
            case .success(let show):
                XCTAssertEqual(show.id, 1)
            case .failure:
                XCTFail("could not reach service.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testWhenRequestingForEspecificShowEpisodes() {
        let expectation = expectation(description: "listShowsEpisodesRequest")
        Task {
            let result = await sut.fetchEpisodesForShow(identifiedBy: 1)
            switch result {
            case .success(let listOfEpisodes):
                XCTAssertFalse(listOfEpisodes.isEmpty)
            case .failure:
                XCTFail("could not reach service.")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
