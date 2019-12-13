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
    var isFiltering: Bool {
      return searchCon.isActive && !isSearchBarEmpty
    }
    var isSearchBarEmpty: Bool {
      return searchCon.searchBar.text?.isEmpty ?? true
    }
    
    @IBOutlet weak var companyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        companyTableView.dataSource = self
        companyTableView.delegate = self
        companyTableView.tableFooterView = UIView()
        companyTableView.separatorStyle = .none
        fetchCompanyList()
        setupSeachBar()
    }
    
    func setupSeachBar() {
        searchCon.searchResultsUpdater = self
        searchCon.obscuresBackgroundDuringPresentation = false
        searchCon.searchBar.placeholder = "Search for companies"
        searchCon.hidesNavigationBarDuringPresentation = true
        navigationItem.searchController = searchCon
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    func fetchCompanyList() {
        ServiceManager.fetchCompaniesAndMembers { (result, error) in
            if let companies = result {
                self.companies = companies
                self.filteredCompanies = companies
                self.companyTableView.reloadData()
            } else {
                if let e = error {
                    print(e.localizedDescription)
                }
            }
        }
    }

    func filterContentForSearchText(_ searchText: String) {
      filteredCompanies = companies.filter { (company: Company) -> Bool in
        return company.company.lowercased().contains(searchText.lowercased())
      }
      companyTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if isFiltering {
          return filteredCompanies.count
        }
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let company: Company
        if isFiltering {
          company = filteredCompanies[indexPath.row]
        } else {
          company = companies[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyCell
        cell.configureCell(company: company)
        return cell
    }
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentForSearchText(text)
    }
    
}

