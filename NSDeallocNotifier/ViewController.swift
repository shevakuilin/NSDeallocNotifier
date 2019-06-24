//
//  ViewController.swift
//  NSDeallocNotifier
//
//  Created by ShevaKuilin on 2019/6/24.
//  Copyright © 2019 ShevaKuilin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test"
    }

    @IBAction func toNext(_ sender: Any) {
        let nextVC = NextViewController()
        self.show(nextVC, sender: nil)
    }
}

