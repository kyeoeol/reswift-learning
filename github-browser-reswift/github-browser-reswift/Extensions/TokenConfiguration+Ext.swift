//
//  TokenConfiguration+Ext.swift
//  github-browser-reswift
//
//  Created by haanwave on 2022/02/27.
//

import Foundation
import OctoKit

extension TokenConfiguration {
    init(data: Data) {
        let json: [String: AnyObject] = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : AnyObject]
        let url = json["endpoint"] as! String
        let accessToken: String? = {
            if case let s = json["accesstoken"] as? String, s != "null" {
                return s
            } else {
                return nil
            }
        }()

        self.init(accessToken, url: url)
    }
    
    func toData() -> Data {
        let json: NSDictionary = [
            "endpoint": self.apiEndpoint,
            "accesstoken": self.accessToken ?? "null"
        ]
        
        return try! JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions(rawValue: 0))
    }
    
}
