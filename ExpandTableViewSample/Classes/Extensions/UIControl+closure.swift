//
//  UIControl+closure.swift
//  MyExtensions
//
//  Created by Daisuke Todate.
//  Copyright © 2017年 Daisuke Todate. All rights reserved.
//
import UIKit

class ClosureSleeve {
    let closure: ()->()

    init(_ closure: @escaping ()->()) {
        self.closure = closure
    }

    @objc func invoke() {
        closure()
    }
}

extension UIControl {
    func add(for controlEvents: UIControlEvents, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }

    func remove(for controlEvents: UIControlEvents) {
        self.removeTarget(nil, action: nil, for: controlEvents)
    }

}
