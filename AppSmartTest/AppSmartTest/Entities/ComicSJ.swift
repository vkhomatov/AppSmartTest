//
//  ComicSJ.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift


class ResponceComicSJ {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: DataComicSJ?
    
    convenience init(from json: JSON) {
        self.init()
        
        self.code = json["code"].intValue
        self.status = json["status"].stringValue
        self.copyright = json["copyright"].stringValue
        self.attributionText = json["attributionText"].stringValue
        self.attributionHTML = json["attributionHTML"].stringValue
        self.data = DataComicSJ(from: json["data"])
        self.etag = json["etag"].stringValue
        
    }
    
}

class DataComicSJ {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [AnyStorySJ]?
    
    convenience init(from json: JSON) {
        self.init()
        
        self.offset = json["offset"].intValue
        self.limit = json["limit"].intValue
        self.total = json["total"].intValue
        self.count = json["count"].intValue
        
        let resultsJSONs = json["results"].arrayValue
        self.results = resultsJSONs.map { AnyStorySJ (from: $0) }
        
    }
}


class AnyStorySJ: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var descriptionSJ: String?
    
    
    var fileExtension: String?
    var path: String?
    
    @objc dynamic var url: URL? {
        if self.fileExtension != "" && self.path != "" {
            if let fileExtension = self.fileExtension {
            return URL(string: securePath(path: path) + "." + fileExtension)
            }
        }
        return nil
    }
    
    convenience init(from json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.descriptionSJ = json["description"].stringValue        
        self.fileExtension = json["thumbnail"]["extension"].stringValue
        self.path = json["thumbnail"]["path"].stringValue
    
    }
    
    func securePath(path: String?) -> String {
        guard let path = path else { return "" }
        if path.hasPrefix("http://") {
            let range = path.range(of: "http://")
            var newPath = path
            newPath.removeSubrange(range!)
            return "https://" + newPath
        } else {
            return path
        }
        
        
    }
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


