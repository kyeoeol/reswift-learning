//
//  AuthState.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/27.
//

import Foundation
import OctoKit
import RequestKit

struct AuthState {
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
    /// 이 프로토콜 메소드와 `OAuthConfiguration`에 대한 구현을 명확하게 하기 위해 첫 번째 인수 이름을 사용하고 있다.
    func handleOpenURL(openURL: URL, completion: @escaping (TokenConfiguration) -> Void)
}

extension OAuthConfiguration: OAuthConfigurationType {
    /// `OAuthConfiguration`의 `handleOpenURL`은 기본 인수를 사용하기 때문에 호출하기 전에  프로토콜을 구현해야 한다.
    func handleOpenURL(openURL: URL, completion: @escaping (TokenConfiguration) -> Void) {
        self.handleOpenURL(url: openURL, completion: completion)
    }
}
