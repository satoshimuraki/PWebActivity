//
//  ViewController.swift
//
//  Copyright © 2017 Satoshi Muraki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - Actions

extension ViewController {

    @IBAction func share(_ sender: Any?) {
        guard let url = URL(string: "https://www.apple.com/") else { return }
        let applicationActivities: [UIActivity] = [
            PSafariActivity(),
            PChromeActivity()
        ]
        let controller = UIActivityViewController(activityItems: [url], applicationActivities: applicationActivities)
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let button = sender as? UIView {
                controller.popoverPresentationController?.sourceRect = button.frame
                controller.popoverPresentationController?.sourceView = self.view
                self.present(controller, animated: true, completion: nil)
            }
        } else {
            self.present(controller, animated: true, completion: nil)
        }
    }

}

