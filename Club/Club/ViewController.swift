//
//  ViewController.swift
//  Club
//
//  Created by Radhika KS01 on 12/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var companyList = [Company]()
    @IBOutlet weak var companyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        companyTableView.dataSource = self
        companyTableView.delegate = self
        ServiceManager.fetchCompaniesAndMembers { (result, error) in
            if let companies = result {
                self.companyList = companies
                self.companyTableView.reloadData()
            } else {
                if let e = error {
                    print(e.localizedDescription)
                }
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let company = companyList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath) as! CompanyCell
        cell.configureCell(company: company)
        return cell
        
    }
    
}

