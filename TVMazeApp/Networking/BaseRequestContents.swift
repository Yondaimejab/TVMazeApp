//
//  BaseRequestContents.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 11/3/25.
//

import NetworkingExtension

public class BaseRequestContents: RequestContents {
    public var method: String
    public var params: [String: Any]
    public var headers: [String : String]
    
    init(method: String, params: [String : Any], headers: [String : String]) {
        self.method = method
        self.params = params
        self.headers = headers
    }
    
    static var empty = BaseRequestContents(method: "", params: [:], headers: [:])
}

extension BaseRequestContents {
    static func buildEmptyContentForGetRequest() -> BaseRequestContents {
        BaseRequestContents(
            method: "GET",
            params: [:],
            headers: [:]
        )
    }
}
