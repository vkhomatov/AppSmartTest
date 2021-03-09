//
//  CharacterSJ.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import Foundation
import SwiftyJSON
import RealmSwift

class ResponceSJ {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var etag: String?
    var data: DataSJ?
    
    convenience init(from json: JSON) {
        self.init()
        self.code = json["code"].intValue
        self.status = json["status"].stringValue
        self.copyright = json["copyright"].stringValue
        self.attributionText = json["attributionText"].stringValue
        self.attributionHTML = json["attributionHTML"].stringValue
        self.data = DataSJ(from: json["data"])
        self.etag = json["etag"].stringValue
    }
}

class DataSJ {
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

class CharacterSJ: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var descriptionSJ: String?
  //  var modified: Date?
  //  var resourceURI: String?
  //  var urls: [UrlSJ]?
  //  var thumbnail: ImageSJ?
    
    @objc dynamic var fileExtension: String?
    @objc dynamic var path: String?
    @objc dynamic var segment = 0

    
    var _comicsSJ = List<ComicsSJ>()
    var comicsSJ: [AnyStoryProtocol] {
        get {
            return _comicsSJ.map { $0 }
        }
        set {
            _comicsSJ.removeAll()
            _comicsSJ.append(objectsIn: newValue.map { $0 as? ComicsSJ ??  ComicsSJ() })
        }
    }

    var _eventsSJ = List<EventsSJ>()
    var eventsSJ: [AnyStoryProtocol] {
        get {
            return _eventsSJ.map { $0 }
        }
        set {
            _eventsSJ.removeAll()
            _eventsSJ.append(objectsIn: newValue.map { $0 as? EventsSJ ?? EventsSJ() })
        }
    }

    var _seriesSJ = List<SeriesSJ>()
    var seriesSJ: [AnyStoryProtocol] {
        get {
            return _seriesSJ.map { $0 }
        }
        set {
            _seriesSJ.removeAll()
            _seriesSJ.append(objectsIn: newValue.map { $0 as? SeriesSJ ?? SeriesSJ() })
        }
    }

    var _storiesSJ = List<StoriesSJ>()
    var storiesSJ: [AnyStoryProtocol] {
        get {
            return _storiesSJ.map { $0 }
        }
        set {
            _storiesSJ.removeAll()
            _storiesSJ.append(objectsIn: newValue.map { $0 as? StoriesSJ ?? StoriesSJ() })
        }
    }
    
    convenience init(from json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.descriptionSJ = json["description"].stringValue
        self.fileExtension = json["thumbnail"]["extension"].stringValue
        self.path = json["thumbnail"]["path"].stringValue
       // self.modified = json["modified"].date
       // self.resourceURI  = json["resourceURI"].stringValue
       // self.thumbnail = ImageSJ(from: json["thumbnail"])

    }
    
   // let urlsJSONs = json["urls"].arrayValue
   // self.urls = urlsJSONs.map { UrlSJ(from: $0) }

    override static func primaryKey() -> String? {
        return "id"
    }
    
}

/*class UrlSJ {
    var type: String?
    var url: String?
    
    convenience init(from json: JSON) {
        self.init()
        self.type = json["type"].stringValue
        self.url = json["url"].stringValue

    }
} */

/*class ImageSJ {

    var fileExtension: String?
    var path: String?

    convenience init(from json: JSON) {
        self.init()
        self.fileExtension = json["extention"].stringValue
        self.path = json["path"].stringValue
    }

} */
