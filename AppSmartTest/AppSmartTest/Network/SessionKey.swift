//
//  SessionKey.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import Foundation

class SessionKey {
    private init() { }
    let publicKey = "d3850db157474a4a5a43641b883f63e7"
    let privateKey = "9d2a628c743354fc1b4c215d4317dd9228384504"
    static let shared = SessionKey()
}
