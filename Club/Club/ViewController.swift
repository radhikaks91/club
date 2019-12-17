//
//  ViewController.swift
//  Club
//
//  Created by Radhika KS01 on 12/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var companies = [Company]()
    var filteredCompanies = [Company]()
    var searchCon = UISearchController(searchResultsController: nil)
    var nameOrder: SortOrder? = .ascending
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var companyTableView: UITableView!
    @IBOutlet weak var tableBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        companyTableView.dataSource = self
        companyTableView.delegate = self
        companyTableView.tableFooterView = UIView()
        companyTableView.separatorStyle = .none
        fetchCompanyList()
        setupSeachBar()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    func setupSeachBar() {
        searchCon.searchResultsUpdater = self
        searchCon.obscuresBackgroundDuringPresentation = false
        searchCon.searchBar.placeholder = AppStrings.searchForCompanies
        searchCon.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchCon
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func fetchCompanyList() {
        activityIndicator.startAnimating()
        ServiceManager.fetchCompaniesAndMembers { (result, error) in
            if let companies = result {
                self.activityIndicator.stopAnimating()
                self.companies = companies
                self.filteredCompanies = self.companies
                self.sortBy(ageOrder: nil, nameOrder: self.nameOrder)
            } else {
                if let e = error {
                    print(e.localizedDescription)
                }
            }
        }
    }

    @objc
    func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableBottomConstraint.constant = -keyboardHeight
        }
    }

    @objc
    func keyboardWillHide(notification: Notification) {
        tableBottomConstraint.constant = 0
    }

    func filterContentForSearchText(_ searchText: String) {
      filteredCompanies = companies.filter { (company: Company) -> Bool in
        return company.company.lowercased().contains(searchText.lowercased())
      }
    }
    
    @IBAction func sortBy(_ sender: Any) {
        performSegue(withIdentifier: StoryboardIdentifiers.viewMembers, sender: self)
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardIdentifiers.sortCompanies {
            if let destinationVC = segue.destination as? SortOrderViewController {
                destinationVC.delegate = self
                destinationVC.feature = .company
                destinationVC.nameOrder = nameOrder
            }
        } else {
            if let destinationVC = segue.destination as? MembersViewController, let company = sender as? Company {
                destinationVC.members = company.members
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCompanies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let company: Company
        company = filteredCompanies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardIdentifiers.companyCell, for: indexPath) as! CompanyCell
        cell.configureCell(company: company)
        return cell
    }
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text == "" {
            filteredCompanies = companies
            sortBy(ageOrder: nil, nameOrder: nameOrder)
        } else {
            filterContentForSearchText(text)
        }
        companyTableView.reloadData()
    }
    
}

extension ViewController: SortTableDelegate {
    func sortBy(ageOrder: SortOrder?, nameOrder: SortOrder?) {
        if let nOrder = nameOrder {
            self.nameOrder = nOrder
            if nOrder == .ascending {
                filteredCompanies.sort { $0.company < $1.company }
            } else {
                filteredCompanies.sort { $0.company > $1.company }
            }
            companyTableView.reloadData()
        }
    }
}

