//
//  NSDeallocNotifier.swift
//  NSDeallocNotifier
//
//  Created by ShevaKuilin on 2019/6/24.
//  Copyright © 2019 ShevaKuilin. All rights reserved.
//

import UIKit

class NSDeallocNotifier: NSObject {
    
    private var block: (() -> ())!
    
    /// 初始化
    ///
    /// - Parameter deallocBlock:   逃逸闭包，在 deinit 中执行
    init(deallocBlock: @escaping (() -> ())) {
        super.init()
        self.block = deallocBlock
    }

    deinit {
        /// 析构时执行 block
        self.block()
        print("\(self.classForCoder) deinit 被执行")
    }
}
