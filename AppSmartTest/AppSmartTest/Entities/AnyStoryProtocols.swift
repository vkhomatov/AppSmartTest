//
//  AnyStoryProtocol.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 07.03.2021.
//

import Foundation
import RealmSwift

protocol AnyStoryResponseProtocol {
    var code: Int? { get set }
    var status: String? { get set }
    var copyright: String? { get set }
    var attributionText: String? { get set }
    var attributionHTML: String? { get set }
    var etag: String? { get set }
    var data: AnyStoryDataProtocol? { get set }
}

protocol AnyStoryDataProtocol {
    var offset: Int? { get set }
    var limit: Int? { get set }
    var total: Int? { get set }
    var count: Int? { get set }
    var results: [AnyStoryProtocol]? { get set }
}

protocol AnyStoryProtocol: Object {
    var id: Int { get set }
    var title: String? { get set }
    var descriptionSJ: String? { get set }
    var fileExtension: String? { get set }
    var path: String? { get set }
    var total: Int  { get set }
}
