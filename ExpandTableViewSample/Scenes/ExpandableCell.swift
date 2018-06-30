//
//  ExpandableCell.swift
//  ExpandTableViewSample
//
//  Created by Daisuke Todate on 2017/12/21.
//  Copyright © 2017年 Daisuke Todate. All rights reserved.
//

import UIKit

class ExpandableCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var subView: UIView!

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!

    @IBOutlet weak var expandButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func expand() {
        if self.subView.isHidden {
            self.subView.isHidden = false
            self.subLabel.isHidden = false
        }
    }

    func contract() {
        if !self.subView.isHidden {
            UIView.animate(withDuration: 0.3) {
                self.subLabel.isHidden = true
                self.subView.isHidden = true
            }
        }
    }
}
