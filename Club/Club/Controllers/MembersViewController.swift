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
    
    var ageOrder: SortOrder? = .ascending
    var nameOrder: SortOrder? = .ascending
    
    @IBOutlet weak var membersTableView: UITableView!
    @IBOutlet weak var tableBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        membersTableView.dataSource = self
        membersTableView.delegate = self
        membersTableView.tableFooterView = UIView()
        membersTableView.separatorStyle = .none
        filteredMembers = members
        sortBy(ageOrder: ageOrder, nameOrder: nameOrder)
        setupSeachBar()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    /**
     Setup the search controller
    */
    func setupSeachBar() {
        searchCon.searchResultsUpdater = self
        searchCon.obscuresBackgroundDuringPresentation = false
        searchCon.searchBar.placeholder = AppStrings.searchForMembers
        searchCon.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchCon
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = AppStrings.members
    }
    
    /**
    Updates the table view bottom constraint when keyboard shows
    */
    @objc
    func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableBottomConstraint.constant = -keyboardHeight
        }
    }

    /**
    Updates the table view bottom constraint when keyboard hides
    */
    @objc
    func keyboardWillHide(notification: Notification) {
        tableBottomConstraint.constant = 0
    }
    
    /**
     Filters the tableview content based on search text
     */
    func filterContentForSearchText(_ searchText: String) {
      filteredMembers = members.filter { (member: Member) -> Bool in
        return member.fullName.lowercased().contains(searchText.lowercased())
      }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? SortOrderViewController {
            destinationVC.delegate = self
            destinationVC.feature = .member
            destinationVC.ageOrder = ageOrder
            destinationVC.nameOrder = nameOrder
        }
    }
    
    /**
     Shows the list of sort orders
    */
    @IBAction func sortBy(_ sender: Any) {
        performSegue(withIdentifier: StoryboardIdentifiers.viewMembers, sender: self)
    }
    
}

extension MembersViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let member: Member
        member = filteredMembers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardIdentifiers.memberCell, for: indexPath) as! MemberCell
        cell.configureCell(member: member)
        return cell
    }

}

extension MembersViewController: UISearchResultsUpdating {
    // MARK: - Search result update
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text == "" {
            filteredMembers = members
            sortBy(ageOrder: ageOrder, nameOrder: nameOrder)
        } else {
            filterContentForSearchText(text)
        }
        membersTableView.reloadData()
    }
    
}

extension MembersViewController: SortTableDelegate {
    /*
     Sorts the list of members based on the criteria selected for Age and Name.
     */
    func sortBy(ageOrder: SortOrder?, nameOrder: SortOrder?) {
        if let aOrder = ageOrder {
            self.ageOrder = aOrder
            if let nOrder = nameOrder {
                self.nameOrder = nOrder
                switch aOrder {
                case .ascending:
                    switch nOrder {
                    case .ascending:
                        filteredMembers.sort { (m1, m2) -> Bool in
                            if m1.age != m2.age {
                                return m1.age < m2.age
                            } else {
                                return m1.fullName < m2.fullName
                            }
                        }
                    case .descending:
                        filteredMembers.sort { (m1, m2) -> Bool in
                            if m1.age != m2.age {
                                return m1.age < m2.age
                            } else {
                                return m1.fullName > m2.fullName
                            }
                        }
                    }
                case .descending:
                    switch nOrder {
                    case .ascending:
                        filteredMembers.sort { (m1, m2) -> Bool in
                            if m1.age != m2.age {
                                return m1.age > m2.age
                            } else {
                                return m1.fullName < m2.fullName
                            }
                        }
                    case .descending:
                        filteredMembers.sort { (m1, m2) -> Bool in
                            if m1.age != m2.age {
                                return m1.age > m2.age
                            } else {
                                return m1.fullName > m2.fullName
                            }
                        }
                    }
                }
            } else {
                self.nameOrder = nil
                if aOrder == .ascending {
                    filteredMembers.sort { $0.age < $1.age }
                } else {
                    filteredMembers.sort { $0.age > $1.age }
                }
            }
            membersTableView.reloadData()
        } else {
            self.ageOrder = nil
            if let nOrder = nameOrder {
                self.nameOrder = nOrder
                if nOrder == .ascending {
                    filteredMembers.sort { $0.fullName < $1.fullName }
                } else {
                    filteredMembers.sort { $0.fullName > $1.fullName }
                }
                membersTableView.reloadData()
            } else {
                self.nameOrder = nil
            }
        }
    }
    
}
