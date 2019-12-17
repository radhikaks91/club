//
//  SortTableViewController.swift
//  Club
//
//  Created by Radhika KS01 on 16/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import UIKit

protocol SortTableDelegate: NSObjectProtocol {
    func sortBy(ageOrder: SortOrder?, nameOrder: SortOrder?)
}

class SortOrderViewController: UIViewController {

    var feature: Feature = .company
    var ageOrder: SortOrder? = .ascending
    var nameOrder: SortOrder? = .ascending
    
    weak var delegate: SortTableDelegate?
    
    @IBOutlet weak var sortOrderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortOrderTableView.tableFooterView = UIView()
    }

    @IBAction func applySort(_ sender: Any) {
        delegate?.sortBy(ageOrder: ageOrder, nameOrder: nameOrder)
        dismiss(animated: true)
    }
    
}

extension SortOrderViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return feature == .company ? 1 : 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardIdentifiers.sortCell, for: indexPath) as! SortCell
        switch feature {
        case .company:
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.accessoryType = (nameOrder == .ascending) ? .checkmark : .none
                } else {
                    cell.accessoryType = (nameOrder == .descending) ? .checkmark : .none
                }
            }
        case .member:
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    cell.accessoryType = (ageOrder == .ascending) ? .checkmark : .none
                } else {
                    cell.accessoryType = (ageOrder == .descending) ? .checkmark : .none
                }
            } else {
                if indexPath.row == 0 {
                    cell.accessoryType = (nameOrder == .ascending) ? .checkmark : .none
                } else {
                    cell.accessoryType = (nameOrder == .descending) ? .checkmark : .none
                }
            }
        }
        cell.configureCell(sort: (indexPath.row % 2 == 0) ? AppStrings.ascending : AppStrings.descending)
        return cell
    }
     
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         if section == 0 {
            return feature == .company ? AppStrings.name : AppStrings.age
         } else {
            return AppStrings.name
         }
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if let cell = tableView.cellForRow(at: indexPath) {
            switch feature {
            case .company:
                if indexPath.section == 0 {
                    if indexPath.row == 0  {
                        nameOrder = (cell.accessoryType == .checkmark) ? nil : .ascending
                    } else {
                        nameOrder = (cell.accessoryType == .checkmark) ? nil : .descending
                    }
                }
            case .member:
                if indexPath.section == 0 {
                    if indexPath.row == 0  {
                        ageOrder = (cell.accessoryType == .checkmark) ? nil : .ascending
                    } else {
                        ageOrder = (cell.accessoryType == .checkmark) ? nil : .descending
                    }
                } else {
                    if indexPath.row == 0  {
                        nameOrder = (cell.accessoryType == .checkmark) ? nil : .ascending
                    } else {
                        nameOrder = (cell.accessoryType == .checkmark) ? nil : .descending
                    }
                }
            }
            tableView.reloadData()
         }
    }
}
