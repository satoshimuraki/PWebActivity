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

    public override var activityType: UIActivity.ActivityType? {
        let className = NSStringFromClass(type(of: self))
        return UIActivity.ActivityType(rawValue: className)
    }

    public override var activityImage: UIImage? {
        let bundle = Bundle(for: type(of: self))
        return UIImage(named: "Safari", in: bundle, compatibleWith: nil)
    }

    public override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return URL.url(from: activityItems) != nil
    }

    public override func prepare(withActivityItems activityItems: [Any]) {
        if let url = URL.url(from: activityItems) {
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
