//
//  Section.swift
//  ExpandTableViewSample
//
//  Created by Daisuke Todate on 2017/12/19.
//  Copyright © 2017年 Daisuke Todate. All rights reserved.
//

import Foundation

struct Section {
    var title: String!
    var elements: [Element]!
    var expanded: Bool!

    init(title: String, elements: [Element], expanded: Bool) {
        self.title = title
        self.elements = elements
        self.expanded = expanded
    }
}
