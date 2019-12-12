//
//  ServiceManager.swift
//  Club
//
//  Created by Radhika KS01 on 12/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import Foundation
import Alamofire

typealias FetchTaskCompletion = (_ result: [Company]?, _ error: Error?) -> Void

class ServiceManager: NSObject
{
    static func fetchCompaniesAndMembers(_ completion: @escaping FetchTaskCompletion) {
        AF.request(Services.fetchCompaniesAndMembers).responseData(completionHandler: { (response) in
            if let data = response.data {
                let jsonDecoder = JSONDecoder()
                do {
                    let tasks = try jsonDecoder.decode([Company].self, from: data)
                    completion(tasks, nil)
                } catch {
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
        })
    }
    
}
