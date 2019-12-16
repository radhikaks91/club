//
//  AppExtensions.swift
//  Club
//
//  Created by Radhika KS01 on 13/12/19.
//  Copyright © 2019 Radhika KS01. All rights reserved.
//

import UIKit

extension UIView {
    var parentViewController: UIViewController?
    {
        var parentResponder: UIResponder? = self
        while parentResponder != nil
        {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController
            {
                return viewController
            }
        }
        return nil
    }
}

