//
//  PChromeActivity.swift
//
//  Copyright © 2017 Satoshi Muraki. All rights reserved.
//

import UIKit

private let kChromeHTTPScheme = "googlechrome"
private let kChromeHTTPSScheme = "googlechromes"

public class PChromeActivity : UIActivity {

    private var url: URL?

    public override var activityTitle: String? {
        return NSLocalizedString("Open in Chrome", comment: "")
    }

    public override var activityType: UIActivityType? {
        let className = NSStringFromClass(type(of: self))
        return UIActivityType(rawValue: className)
    }

    public override var activityImage: UIImage? {
        return UIImage(named: "Chrome")
    }

    private var isChromeInstalled: Bool {
        guard let url = URL(string: "\(kChromeHTTPScheme):") else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    private func url(from activityItems: [Any]) -> URL? {
        for item in activityItems {
            if let url = item as? URL {
                return url
            }
        }
        return nil
    }

    public override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        guard isChromeInstalled else { return false }
        return url(from: activityItems) != nil
    }

    public override func prepare(withActivityItems activityItems: [Any]) {
        if let url = url(from: activityItems) {
            self.url = url
        }
    }

    public override func perform() {
        guard let url = self.url else { return }
        let string = url.absoluteString
        guard let range = string.range(of: ":") else { return }
        let scheme = string.substring(to: range.lowerBound).lowercased()
        let afterScheme = string.substring(from: range.upperBound)
        let newString: String
        if scheme == "http" {
            newString = "\(kChromeHTTPScheme):\(afterScheme)"
        } else if scheme == "https" {
            newString = "\(kChromeHTTPSScheme):\(afterScheme)"
        } else {
            return
        }
        guard let newURL = URL(string: newString) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(newURL)
        } else {
            UIApplication.shared.openURL(newURL)
        }
    }

}
