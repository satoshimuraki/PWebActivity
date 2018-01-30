//
//  PWebActivityUtility.swift
//
//  Copyright © 2018 Satoshi Muraki. All rights reserved.
//

import Foundation

extension String {

    var containedWebURLs: [URL] {
        let pattern = "https?:\\/\\/(www\\.)?[-a-zA-Z0-9@:%._\\+~#=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%_\\+.~#?&//=]*)"
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: self, options: [], range: NSMakeRange(0, self.count))
        var result: [URL] = []
        for match in matches {
            let range = match.range(at: 0)
            let urlText = (self as NSString).substring(with: range)
            if let url = URL(string: urlText) {
                result.append(url)
            }
        }
        return result
    }

}

extension URL {

    static func url(from activityItems: [Any]) -> URL? {
        return activityItems.flatMap({ $0 as? URL }).first ??
               activityItems.flatMap({ $0 as? String }).flatMap({ $0.containedWebURLs.first }).first
    }

}
