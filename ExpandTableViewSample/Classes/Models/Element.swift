//
//  Element.swift
//  ExpandTableViewSample
//
//  Created by Daisuke Todate on 2017/12/19.
//  Copyright © 2017年 Daisuke Todate. All rights reserved.
//

import Foundation

struct Element {
    var title: String!
    var subtitle: String!
    var expanded: Bool!

    init(title: String, expanded: Bool) {
        self.title = title
        self.subtitle = "\(title)-Sub"
        self.expanded = expanded
    }
}
