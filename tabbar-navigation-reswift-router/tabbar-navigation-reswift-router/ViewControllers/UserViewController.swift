//
//  UserViewController.swift
//  navigation-reswift-router
//
//  Created by haanwave on 2022/02/27.
//

import UIKit
import ReSwift
import ReSwiftRouter

class UserViewController: UIViewController, Routable {
    static let identifier = "UserViewController"
    
    var userDetailViewController: Routable!
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                          animated: Bool,
                          completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        userDetailViewController = storyboard.instantiateViewController(withIdentifier: UserDetailViewController.identifier) as? Routable
        
        present(userDetailViewController as! UIViewController,
                animated: true,
                completion: completionHandler)
        
        return userDetailViewController
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                         animated: Bool,
                         completionHandler: @escaping RoutingCompletionHandler) {
        
        dismiss(animated: true,
                completion: completionHandler)
    }
    
    @IBAction func tapPushButton(_ sender: UIButton) {
        mainStore.dispatch(
            SetRouteAction([
                "TabBarController",
                UserViewController.identifier,
                UserDetailViewController.identifier
            ])
        )
    }
}
