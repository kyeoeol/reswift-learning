//
//  AuthenticationService.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/01.
//

import Foundation
import SAMKeychain
import OctoKit

class AuthenticationService {
    private let forService = "GitHubAuth"
    private let account = "TokenConfiguration"
    
    func authenticationData() -> TokenConfiguration? {
        guard let authData = SAMKeychain.passwordData(forService: forService, account: account) else {
            return nil
        }
        return TokenConfiguration(data: authData)
    }
    
    func saveAuthenticationData(with token: TokenConfiguration) {
        let authData = token.toData()
        SAMKeychain.setPasswordData(authData, forService: forService, account: account)
    }
}
