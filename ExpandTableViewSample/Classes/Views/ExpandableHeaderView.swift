//
//  ExpandableHeaderView.swift
//  ExpandTableViewSample
//
//  Created by Daisuke Todate on 2017/12/19.
//  Copyright © 2017年 Daisuke Todate. All rights reserved.
//

import UIKit

protocol ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int)
}

class ExpandableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!

    override func awakeFromNib() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }

    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
