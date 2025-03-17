//
//  String+Extension.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 11/3/25.
//

import Foundation

extension String {
    func indexForTrimmingExactly(wordCount: Int) -> String.Index? {
        let wordComponents = components(separatedBy: .whitespaces)
        guard wordComponents.count >= wordCount else { return nil }
        let offset = wordComponents.dropFirst(wordCount).map({ $0.count }).reduce(0, { $0 + $1 })
        return index(startIndex, offsetBy: offset)
    }
    
    func trimmedTo(wordCount: Int) -> String? {
        guard let rangeEndIndex = indexForTrimmingExactly(wordCount: wordCount) else { return nil }
        return String(self[startIndex...rangeEndIndex])
    }
}
