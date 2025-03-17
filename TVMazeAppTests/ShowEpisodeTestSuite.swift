//
//  ShowEpisodeTestSuite.swift
//  TVMazeAppTests
//
//  Created by Joel Alcantara on 16/3/25.
//

import XCTest
@testable import TVMazeApp

final class ShowEpisodeTestSuite: XCTestCase {
    var showEpisodes: [ShowEpisode] = [
        ShowEpisode(
            id: 2,
            name: "some",
            url: "",
            image: nil,
            summary: "summary",
            season: 2,
            number: 1,
            type: "type",
            rating: nil
        ),
        ShowEpisode(
            id: 1,
            name: "some",
            url: "",
            image: nil,
            summary: "summary",
            season: 1,
            number: 1,
            type: "type",
            rating: nil
        )
    ]
    
    func testCustomSortForEpisodeListShouldBeOrdered() {
        var isOrdered = true
        for (index, item) in showEpisodes.enumerated() {
            guard index != showEpisodes.index(before: showEpisodes.endIndex) else { return }
            let nextIndex = showEpisodes.index(after: index)
            let secondItem = showEpisodes[nextIndex]
            isOrdered = item.season < secondItem.season && item.id < secondItem.id
            if !isOrdered {
                break
            }
        }
        XCTAssertFalse(isOrdered)
        showEpisodes.customSort()
        for (index, item) in showEpisodes.enumerated() {
            guard index != showEpisodes.index(before: showEpisodes.endIndex) else { return }
            let nextIndex = showEpisodes.index(after: index)
            let secondItem = showEpisodes[nextIndex]
            isOrdered = item.season < secondItem.season && item.id < secondItem.id
            if !isOrdered {
                break
            }
        }
        XCTAssertFalse(isOrdered)
    }
}
