//
//  RequestError.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 15/3/25.
//

import UIKit

enum RequestError: Error {
    case requestFailed
    case couldNotBuildRequest
    case decodingFailed
    case elementsLimitReached
}
