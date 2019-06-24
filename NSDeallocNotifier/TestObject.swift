//
//  TestObject.swift
//  NSDeallocNotifier
//
//  Created by ShevaKuilin on 2019/6/24.
//  Copyright © 2019 ShevaKuilin. All rights reserved.
//

import UIKit

class TestObject: NSObject {
    deinit {
        print("\(self.classForCoder) is released!")
    }
}
