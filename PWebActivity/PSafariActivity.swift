//
//  PSafariActivity.swift
//
//  Copyright © 2017 Satoshi Muraki. All rights reserved.
//

import UIKit

public class PSafariActivity : UIActivity {

    private var url: URL?

    public override var activityTitle: String? {
        let bundle = Bundle(for: type(of: self))
        return bundle.localizedString(forKey: "Open in Safari", value: "Open in Safari", table: nil)
    }

    public override var activityType: UIActivityType? {
        let className = NSStringFromClass(type(of: self))
        return UIActivityType(rawValue: className)
    }

    public override var activityImage: UIImage? {
        let bundle = Bundle(for: type(of: self))
        return UIImage(named: "Safari", in: bundle, compatibleWith: nil)
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
        return url(from: activityItems) != nil
    }

    public override func prepare(withActivityItems activityItems: [Any]) {
        if let url = url(from: activityItems) {
            self.url = url
        }
    }

    public override func perform() {
        guard let url = self.url else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

}
