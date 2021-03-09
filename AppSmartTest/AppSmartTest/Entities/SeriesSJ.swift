//
//  SeriesSJ.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 07.03.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift

class ResponceSeriesSJ: AnyStoryResponseProtocol {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: AnyStoryDataProtocol?
    
    convenience init(from json: JSON) {
        self.init()
        self.code = json["code"].intValue
        self.status = json["status"].stringValue
        self.copyright = json["copyright"].stringValue
        self.attributionText = json["attributionText"].stringValue
        self.attributionHTML = json["attributionHTML"].stringValue
        self.etag = json["etag"].stringValue
        self.data = DataSeriesSJ(from: json["data"])
    }
}

class DataSeriesSJ: AnyStoryDataProtocol {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [AnyStoryProtocol]?
    
    convenience init(from json: JSON) {
        self.init()
        self.offset = json["offset"].intValue
        self.limit = json["limit"].intValue
        self.total = json["total"].intValue
        self.count = json["count"].intValue
        let resultsJSONs = json["results"].arrayValue
        self.results = resultsJSONs.map { SeriesSJ (from: $0) }
    }
}

class SeriesSJ: Object, AnyStoryProtocol {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var descriptionSJ: String?
    @objc dynamic var fileExtension: String?
    @objc dynamic var path: String?
    var total: Int = 0

    
    convenience init(from json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.descriptionSJ = json["description"].stringValue
        self.fileExtension = json["thumbnail"]["extension"].stringValue
        self.path = json["thumbnail"]["path"].stringValue
    }
}
