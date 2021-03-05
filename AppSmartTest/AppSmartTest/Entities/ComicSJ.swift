//
//  ComicSJ.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import Foundation
import SwiftyJSON


class ResponceComicSJ {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    //  var data: DataSJ?
    
    var dataOffset: Int?
    var dataLimit: Int?
    var dataTotal: Int?
    var dataCount: Int?
    var dataResults: [CharacterSJ]?
    
    convenience init(from json: JSON) {
        self.init()
        
        self.code = json["code"].intValue
        self.status = json["status"].stringValue
        self.copyright = json["copyright"].stringValue
        self.attributionText = json["attributionText"].stringValue
        self.attributionHTML = json["attributionHTML"].stringValue
        //   self.data = json["data"].rawValue as? DataSJ
        self.etag = json["etag"].stringValue
        
        self.dataOffset = json["data"]["offset"].intValue
        self.dataLimit = json["data"]["limit"].intValue
        self.dataTotal = json["data"]["total"].intValue
        self.dataCount = json["data"]["count"].intValue
        
        let dataResultsJSONs = json["data"]["results"].arrayValue
        self.dataResults = dataResultsJSONs.map { CharacterSJ(from: $0) }
        
        
        //        let dataJSONs = json["data"].arrayValue
        //        self.data = dataJSONs.map { DataSJ (from: $0) }
        
    }
    
}

class DataComicSJ {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [CharacterSJ]?
    
    convenience init(from json: JSON) {
        self.init()
        
        self.offset = json["offset"].intValue
        self.limit = json["limit"].intValue
        self.total = json["total"].intValue
        self.count = json["count"].intValue
        
        let resultsJSONs = json["results"].arrayValue
        self.results = resultsJSONs.map { CharacterSJ (from: $0) }
        
    }
}


class AnyStorySJ {
    
    var id: Int?
    var title: String?
    var description: String?
    //  var thumbnail: ImageSJ?
    
    
    var fileExtension: String?
    var path: String?
    
    var url: URL? {
        return URL(string: securePath(path: self.path) + "." + self.fileExtension!)
    }
    
    convenience init(from json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.description = json["description"].stringValue
        // self.thumbnail = json["thumbnail"].rawValue as? ImageSJ
        
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
}


//class StoriSJ {
//
//    var id: Int?
//    var title: String?
//    var description: String?
//    var thumbnail: ImageSJ?
//
//    convenience init(from json: JSON) {
//        self.init()
//        self.id = json["id"].intValue
//        self.title = json["title"].stringValue
//        self.description = json["description"].stringValue
//        self.thumbnail = json["thumbnail"].rawValue as? ImageSJ
//
//    }
//
//}

