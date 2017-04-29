//
//  PSafariActivity.swift
//
//  Copyright © 2017 Satoshi Muraki. All rights reserved.
//

import UIKit

class PSafariActivity : UIActivity {

    private var url: URL?

    override var activityTitle: String? {
        return NSLocalizedString("Open in Safari", comment: "")
    }

    override var activityType: UIActivityType? {
        let className = NSStringFromClass(type(of: self))
        return UIActivityType(rawValue: className)
    }

    override var activityImage: UIImage? {
        return UIImage(named: "Safari")
    }

    private func url(from activityItems: [Any]) -> URL? {
        for item in activityItems {
            if let url = item as? URL {
                return url
            }
        }
        return nil
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return url(from: activityItems) != nil
    }

    override func prepare(withActivityItems activityItems: [Any]) {
        if let url = url(from: activityItems) {
            self.url = url
        }
    }

    override func perform() {
        guard let url = self.url else { return }
        UIApplication.shared.open(url)
    }

}
