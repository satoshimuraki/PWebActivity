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
        let bundle = Bundle(for: type(of: self))
        return bundle.localizedString(forKey: "Open in Chrome", value: "Open in Chrome", table: nil)
    }

    public override var activityType: UIActivityType? {
        let className = NSStringFromClass(type(of: self))
        return UIActivityType(rawValue: className)
    }

    public override var activityImage: UIImage? {
        let bundle = Bundle(for: type(of: self))
        return UIImage(named: "Chrome", in: bundle, compatibleWith: nil)
    }

    private var isChromeInstalled: Bool {
        guard let url = URL(string: "\(kChromeHTTPScheme):") else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    public override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        guard isChromeInstalled else { return false }
        return URL.url(from: activityItems) != nil
    }

    public override func prepare(withActivityItems activityItems: [Any]) {
        if let url = URL.url(from: activityItems) {
            self.url = url
        }
    }

    public override func perform() {
        guard let url = self.url else { return }
        let string = url.absoluteString
        guard let range = string.range(of: ":") else { return }
        let scheme = string.prefix(upTo: range.lowerBound).lowercased()
        let afterScheme = string.suffix(from: range.upperBound)
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
