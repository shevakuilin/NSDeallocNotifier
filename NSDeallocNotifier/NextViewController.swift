//
//  NextViewController.swift
//  NSDeallocNotifier
//
//  Created by ShevaKuilin on 2019/6/24.
//  Copyright © 2019 ShevaKuilin. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    private static var _mapTable = NSMapTable<NSString, AnyObject>(keyOptions: .strongMemory, valueOptions: .weakMemory)
    
    private struct AssociatedKey {
        static var objcKey = "objcKey"
    }
    
    private var testObjc = TestObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigation()
//        let objc = NSObject()
        NextViewController._mapTable.setObject(testObjc, forKey: "Key")
        let notifier = NSDeallocNotifier {
            /// 在 deinit 执行时，释放 NSMapTable 中的值
            NextViewController._mapTable.removeObject(forKey: "Key")
            print("NSDeallocNotifier 回调执行完毕，释放 NSMapTable 中的值")
            print(NextViewController._mapTable)
        }
        /// 关联对象
        /// 当若持有对象被 deinit 时，NSDeallocNotifier 也会被 deinit，从而出发上面的回调
        objc_setAssociatedObject(testObjc, &AssociatedKey.objcKey, notifier, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    deinit {
        print("\(self.classForCoder) is released!")
    }
}

private extension NextViewController {
    private func initNavigation() {
        self.title = "Next"
        self.view.backgroundColor = .purple
        let leftItem: UIBarButtonItem = UIBarButtonItem(title: "Dimiss", style: .done, target: self, action: #selector(dismissAction))
        self.navigationItem.leftBarButtonItem = leftItem
    }
}

private extension NextViewController {
    @objc private func dismissAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
