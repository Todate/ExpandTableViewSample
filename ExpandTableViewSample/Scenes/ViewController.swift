//
//  ViewController.swift
//  ExpandTableViewSample
//
//  Created by Daisuke Todate on 2017/12/19.
//  Copyright © 2017年 Daisuke Todate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var sections = [
        Section(title: "Section A", elements: [
            Element(title: "A1", expanded: false),
            Element(title: "A2", expanded: false),
            Element(title: "A3", expanded: false),
            Element(title: "A4", expanded: false)
        ], expanded: true),
        Section(title: "Section B", elements: [
            Element(title: "B1", expanded: false),
            Element(title: "B2", expanded: false)
        ], expanded: false),
        Section(title: "Section C", elements: [
            Element(title: "C1", expanded: false),
            Element(title: "C2", expanded: false)
        ], expanded: false),
        Section(title: "Section D", elements: [
            Element(title: "D1", expanded: false),
            Element(title: "D2", expanded: false)
        ], expanded: false),
        Section(title: "Section E", elements: [
            Element(title: "E1", expanded: false),
            Element(title: "E2", expanded: false)
        ], expanded: false),
        Section(title: "Section F", elements: [
            Element(title: "F1", expanded: false),
            Element(title: "F2", expanded: false)
        ], expanded: false),
        Section(title: "Section G", elements: [
            Element(title: "G1", expanded: false),
            Element(title: "G2", expanded: false)
        ], expanded: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "ExpandableHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "ExpandableHeaderView")

        tableView.delegate = self
        tableView.dataSource = self

        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func editButtonDidTap(_ sender: UIBarButtonItem) {
        print(#function)
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        print(#function)
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

    @IBAction func expandButtonDidTap(_ sender: UIButton) {
        // button -> view -> stackView -> TableCell
        let cell = sender.superview?.superview?.superview?.superview as! ExpandableCell

        guard let indexPath = tableView.indexPath(for: cell) else { return }

        sections[indexPath.section].elements[indexPath.row].expanded = !sections[indexPath.section].elements[indexPath.row].expanded

        tableView.beginUpdates()

        if sections[indexPath.section].elements[indexPath.row].expanded {
            cell.expand()
        } else {
            cell.contract()
        }

        tableView.endUpdates()
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.section)-\(indexPath.row)")

        if !tableView.isEditing {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle(rawValue: 3)!
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].elements.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !sections[indexPath.section].expanded {
            return 0
        } else {
            return UITableViewAutomaticDimension
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpandableHeaderView") as! ExpandableHeaderView
        header.titleLabel.text = sections[section].title
        header.section = section
        header.delegate = self
        header.iconImageView.backgroundColor = sections[section].expanded ? .red : .yellow
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell") as! ExpandableCell

        cell.mainLabel.text = sections[indexPath.section].elements[indexPath.row].title
        cell.subLabel.text = "\(sections[indexPath.section].elements[indexPath.row].title!)-Sub"

        cell.subView.isHidden = !self.sections[indexPath.section].elements[indexPath.row].expanded

        return cell
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteButton = UITableViewRowAction(style: .normal, title: "削除") { (action, indexPath) in
            // do something...
        }

        deleteButton.backgroundColor = UIColor.init(hex: 0xff3b30)

        return [deleteButton]
    }
}

extension ViewController: ExpandableHeaderViewDelegate {
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        header.iconImageView.backgroundColor = sections[section].expanded ? .red : .yellow

        tableView.beginUpdates()

        for i in 0 ..< sections[section].elements.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }

        tableView.endUpdates()
    }
}
