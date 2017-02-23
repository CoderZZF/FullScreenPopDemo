//
//  XMGNavigationController.swift
//  XMGTV
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

class XMGNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. 校验手势是否有值
        // target/action
        guard let interactivePop = interactivePopGestureRecognizer else { return }
        
        
//        // 2. 通过运行时机制找到想要的属性
//        var count : UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count {
//            let ivar = ivars[Int(i)]
//            let nameP = ivar_getName(ivar)
//            let name = String(cString: nameP!)
//            print(name)
//        }
        
        guard let values = interactivePop.value(forKeyPath: "_targets") as? [NSObject] else { return }
        
        guard let objc = values.first else { return }
        
//         3. 取出action/target
//        print(objc)
        let target = objc.value(forKeyPath: "target")
        let action = Selector(("handleNavigationTransition:"))
//        let action = objc.value(forKeyPath: "action") as? Selector
        
        
//        // 2. 创建自己的手势
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(panGes)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
