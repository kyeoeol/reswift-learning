//
//  SignInViewController.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/27.
//

import UIKit
import ReSwift
import ReSwiftRouter
import SafariServices

class LoginViewController: UIViewController {
    @IBAction func tapAuthenticateButton(_ sender: UIButton) {
        mainStore.dispatch(
            authenticationUser
        )
    }
}

// MARK: - SFSafariViewControllerDelegate
extension LoginViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        print("--->[LoginViewController] safariViewControllerDidFinish")
        
        mainStore.dispatch(
            SetRouteAction([
                MainRoute
            ])
        )
    }
}
