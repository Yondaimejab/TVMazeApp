//
//  BaseRequestBuilder.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 11/3/25.
//

import NetworkingExtension
import Foundation

class BaseRequestBuilder: RequestBuilder {
    var router: Router
    var contents: any RequestContents

    init(router: Router, contents: any RequestContents) {
        self.router = router
        self.contents = contents
    }
}
