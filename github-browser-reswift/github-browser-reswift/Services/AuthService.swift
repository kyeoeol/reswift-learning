//
//  AuthService.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/27.
//

import Foundation
import SAMKeychain
import OctoKit

class AuthService {
    func authData() -> TokenConfiguration? {
        guard let data = SAMKeychain.passwordData(forService: "GitHubAuth", account: "TokenConfiguration") else {
            return nil
        }
        return TokenConfiguration(data: data)
    }
    
    func saveAuthData(_ token: TokenConfiguration) {
        let data = token.toData()
        SAMKeychain.setPasswordData(data, forService: "GitHubAuth", account: "TokenConfiguration")
    }
}
