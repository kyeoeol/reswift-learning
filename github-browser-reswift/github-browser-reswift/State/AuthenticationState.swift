//
//  AuthenticationState.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/03/01.
//

import Foundation
import OctoKit
import RequestKit

struct AuthenticationState {
    var oAuthConfig: OAuthConfigurationType?
    var oAuthURL: URL?
    var loggedInState: LoggedInState
}

enum LoggedInState {
    case notLoggedIn
    case loggedIn(TokenConfiguration)
}

protocol OAuthConfigurationType {
    func authenticate() -> URL?
    
    /// 이 프로토콜 메서드와 `OAuthConfiguration`의 구현을 명확하게 구분하기 위해
    /// `openUrl` 파라미터 이름을 사용한다.
    func handleOpenURL(openUrl: URL, completion: @escaping (TokenConfiguration) -> Void)
}

extension OAuthConfiguration: OAuthConfigurationType {
    
    /// `OAuthConfigurationType` 프로토콜 구현을 통해 `handleOpenURL`을 수행한다.
    func handleOpenURL(openUrl: URL, completion: @escaping (TokenConfiguration) -> Void) {
        self.handleOpenURL(url: openUrl, completion: completion)
    }
}
