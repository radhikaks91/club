//
//  MembersViewController.swift
//  Club
//
//  Created by Radhika KS01 on 13/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController {
    
    var members = [Member]()
    var filteredMembers = [Member]()
    var searchCon = UISearchController(searchResultsController: nil)
    var isFiltering: Bool {
      return searchCon.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty: Bool {
      return searchCon.searchBar.text?.isEmpty ?? true
    }
    var sortOrder = SortOrder.nameAsc
    
    @IBOutlet weak var membersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        membersTableView.dataSource = self
        membersTableView.delegate = self
        membersTableView.tableFooterView = UIView()
        membersTableView.separatorStyle = .none
        membersTableView.reloadData()
        setupSeachBar()
    }
    
    func setupSeachBar() {
        searchCon.searchResultsUpdater = self
        searchCon.obscuresBackgroundDuringPresentation = false
        searchCon.searchBar.placeholder = AppStrings.searchForMembers
        searchCon.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchCon
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = AppStrings.members
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredMembers = members.filter { (member: Member) -> Bool in
        return member.fullName.lowercased().contains(searchText.lowercased())
      }
      membersTableView.reloadData()
    }
    
    @IBAction func sortBy(_ sender: Any) {
        let ac = UIAlertController(title: AppStrings.sortBy, message: nil, preferredStyle: .actionSheet)
        let nameAsc = UIAlertAction(title: AppStrings.nameAsc, style: .default, handler: sortContentBy)
        let nameDesc = UIAlertAction(title: AppStrings.nameDesc, style: .default, handler: sortContentBy)
        let ageAsc = UIAlertAction(title: AppStrings.ageAsc, style: .default, handler: sortContentBy)
        let ageDesc = UIAlertAction(title: AppStrings.ageDesc, style: .default, handler: sortContentBy)
        let ageNameAsc = UIAlertAction(title: AppStrings.ageNameAsc, style: .default, handler: sortContentBy)
        let ageNameDesc = UIAlertAction(title: AppStrings.ageNameDesc, style: .default, handler: sortContentBy)
        switch sortOrder {
        case .nameAsc:
            nameAsc.setValue(UIImage(systemName: "checkmark"), forKey: "image")
        case .nameDesc:
            nameDesc.setValue(UIImage(systemName: "checkmark"), forKey: "image")
        case .ageAsc:
            ageAsc.setValue(UIImage(systemName: "checkmark"), forKey: "image")
        case .ageDesc:
            ageDesc.setValue(UIImage(systemName: "checkmark"), forKey: "image")
        case .ageNameAsc:
            ageNameAsc.setValue(UIImage(systemName: "checkmark"), forKey: "image")
        case .ageNameDesc:
            ageNameDesc.setValue(UIImage(systemName: "checkmark"), forKey: "image")
        }
        ac.addAction(nameAsc)
        ac.addAction(nameDesc)
        ac.addAction(ageAsc)
        ac.addAction(ageDesc)
        ac.addAction(ageNameAsc)
        ac.addAction(ageNameDesc)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func sortContentBy(action: UIAlertAction) {
        guard let title = action.title else {
            return
        }
        switch title {
        case AppStrings.nameAsc:
            sortOrder = .nameAsc
            filteredMembers.sort { $0.fullName < $1.fullName }
            members.sort { $0.fullName < $1.fullName }
            membersTableView.reloadData()
        case AppStrings.nameDesc:
            sortOrder = .nameDesc
            filteredMembers.sort { $0.fullName > $1.fullName }
            members.sort { $0.fullName > $1.fullName }
            membersTableView.reloadData()
        case AppStrings.ageAsc:
            sortOrder = .ageAsc
            filteredMembers.sort { $0.age < $1.age }
            members.sort { $0.age < $1.age }
            membersTableView.reloadData()
        case AppStrings.ageDesc:
            sortOrder = .ageDesc
            filteredMembers.sort { $0.age > $1.age }
            members.sort { $0.age > $1.age }
            membersTableView.reloadData()
        case AppStrings.ageNameAsc:
            sortOrder = .ageNameAsc
            filteredMembers.sort { (m1, m2) -> Bool in
                if m1.age != m2.age {
                    return m1.age < m2.age
                } else {
                    return m1.fullName < m2.fullName
                }
            }
            members.sort { (m1, m2) -> Bool in
                if m1.age != m2.age {
                    return m1.age < m2.age
                } else {
                    return m1.fullName < m2.fullName
                }
            }
            membersTableView.reloadData()
        case AppStrings.ageNameDesc:
            sortOrder = .ageNameDesc
            filteredMembers.sort { (m1, m2) -> Bool in
                if m1.age != m2.age {
                    return m1.age > m2.age
                } else {
                    return m1.fullName > m2.fullName
                }
            }
            members.sort { (m1, m2) -> Bool in
                if m1.age != m2.age {
                    return m1.age > m2.age
                } else {
                    return m1.fullName > m2.fullName
                }
            }
            membersTableView.reloadData()
        default:
            print("Sort Order: None")
        }
    }
    
}

extension MembersViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
          return filteredMembers.count
        }
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let member: Member
        if isFiltering {
          member = filteredMembers[indexPath.row]
        } else {
          member = members[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardIdentifiers.memberCell, for: indexPath) as! MemberCell
        cell.configureCell(member: member)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension MembersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentForSearchText(text)
    }
    
}
