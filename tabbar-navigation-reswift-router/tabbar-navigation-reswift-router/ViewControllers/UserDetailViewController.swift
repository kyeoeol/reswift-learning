//
//  SubViewController.swift
//  navigation-reswift-router
//
//  Created by haanwave on 2022/02/27.
//

import UIKit
import ReSwift
import ReSwiftRouter

class UserDetailViewController: UIViewController, Routable {
    static let identifier = "UserDetailViewController"
    
    @IBAction func tapPopButton(_ sender: UIButton) {
        mainStore.dispatch(
            SetRouteAction([
                "TabBarController",
                UserViewController.identifier
            ])
        )
    }
}
