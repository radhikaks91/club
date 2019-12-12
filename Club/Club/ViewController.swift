//
//  ViewController.swift
//  Club
//
//  Created by Radhika KS01 on 12/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ServiceManager.fetchCompaniesAndMembers { (result, error) in
            if let companies = result {
                print(companies)
            } else {
                if let e = error {
                    print(e.localizedDescription)
                }
            }
        }
    }


}

