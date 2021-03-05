//
//  CharacterSJ.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import Foundation
import SwiftyJSON


//Character {
//id (int, optional): The unique ID of the character resource.,
//name (string, optional): The name of the character.,
//description (string, optional): A short bio or description of the character.,
//modified (Date, optional): The date the resource was most recently modified.,
//resourceURI (string, optional): The canonical URL identifier for this resource.,
//urls (Array[Url], optional): A set of public web site URLs for the resource.,
//thumbnail (Image, optional): The representative image for this character.,
//comics (ComicList, optional): A resource list containing comics which feature this character.,
//stories (StoryList, optional): A resource list of stories in which this character appears.,
//events (EventList, optional): A resource list of events in which this character appears.,
//series (SeriesList, optional): A resource list of series in which this character appears.
//}

//CharacterDataWrapper {
//code (int, optional): The HTTP status code of the returned result.,
//status (string, optional): A string description of the call status.,
//copyright (string, optional): The copyright notice for the returned result.,
//attributionText (string, optional): The attribution notice for this result. Please display either this notice or the contents of the attributionHTML field on all screens which contain data from the Marvel Comics API.,
//attributionHTML (string, optional): An HTML representation of the attribution notice for this result. Please display either this notice or the contents of the attributionText field on all screens which contain data from the Marvel Comics API.,
//data (CharacterDataContainer, optional): The results returned by the call.,
//etag (string, optional): A digest value of the content returned by the call.
//}
//CharacterDataContainer {
//offset (int, optional): The requested offset (number of skipped results) of the call.,
//limit (int, optional): The requested result limit.,
//total (int, optional): The total number of resources available given the current filter set.,
//count (int, optional): The total number of results returned by this call.,
//results (Array[Character], optional): The list of characters returned by the call.
//}


class ResponceSJ {
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
   //     self.data = json["data"].rawValue as? DataSJ
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

//class DataSJ {
//    var offset: Int?
//    var limit: Int?
//    var total: Int?
//    var count: Int?
//    var results: [CharacterSJ]?
//    
//    convenience init(from json: JSON) {
//        self.init()
//        
//        self.offset = json["offset"].intValue
//        self.limit = json["limit"].intValue
//        self.total = json["total"].intValue
//        self.count = json["count"].intValue
//        
//        let resultsJSONs = json["results"].arrayValue
//        self.results = resultsJSONs.map { CharacterSJ (from: $0) }
//        
//    }
//}



class CharacterSJ {
    
    var id: Int?
    var name: String?
    var description: String?
    var modified: Date?
    var resourceURI: String?
    var urls: [UrlSJ]?
    
 //   var thumbnail: ImageSJ?
 //   var comics: ComicsSJ?
  //  var events: ComicsSJ?
  //  var series: ComicsSJ?
 //   var stories: StoriesSJ?

    
    var fileExtension: String?
    var path: String?
    
    var url: URL? {
            if let fileExtension = self.fileExtension {
                 return URL(string: securePath(path: self.path) + "." + fileExtension)
            }
        return nil
    }
    
    
    var comicsSJ = [AnyStorySJ]()
    var eventsSJ = [AnyStorySJ]()
    var seriesSJ = [AnyStorySJ]()
    var storiesSJ = [AnyStorySJ]()
    var segment = 0
    
  //  var characterSJ: CharacterSJ?

    
    
    
    var comicsAvailable, comicsReturned: Int?
    var comicsCollectionURI: String?
    var comicsItems: [ComicsItemSJ]?
    
    var eventsAvailable, eventsReturned: Int?
    var eventsCollectionURI: String?
    var eventsItems: [ComicsItemSJ]?
    
    var seriesAvailable, seriesReturned: Int?
    var seriesCollectionURI: String?
    var seriesItems: [ComicsItemSJ]?
    
    var storiesAvailable, storiesReturned: Int?
    var storiesCollectionURI: String?
    var storiesItems: [StoriesItemSJ]?

    
    convenience init(from json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.description = json["description"].stringValue
        self.modified = json["modified"].rawValue as? Date
        self.resourceURI = json["resourceURI"].stringValue
        
        
       // self.thumbnail = json["thumbnail"].rawValue as? ImageSJ
        self.fileExtension = json["thumbnail"]["extension"].stringValue
        self.path = json["thumbnail"]["path"].stringValue
        
        
        self.comicsAvailable = json["comics"]["avaiable"].intValue
        self.comicsReturned = json["comics"]["returned"].intValue
        let comicsItemsJSONs = json["comics"]["items"].arrayValue
        self.comicsItems = comicsItemsJSONs.map { ComicsItemSJ(from: $0) }
        
        
        self.eventsAvailable = json["events"]["avaiable"].intValue
        self.eventsReturned = json["events"]["returned"].intValue
        let eventsItemsJSONs = json["events"]["items"].arrayValue
        self.eventsItems = eventsItemsJSONs.map { ComicsItemSJ(from: $0) }
        
        self.seriesAvailable = json["series"]["avaiable"].intValue
        self.seriesReturned = json["series"]["returned"].intValue
        let seriesItemsJSONs = json["series"]["items"].arrayValue
        self.seriesItems = seriesItemsJSONs.map { ComicsItemSJ(from: $0) }
        
        self.storiesAvailable = json["stories"]["avaiable"].intValue
        self.storiesReturned = json["stories"]["returned"].intValue
        let storiesItemsJSONs = json["stories"]["items"].arrayValue
        self.storiesItems = storiesItemsJSONs.map { StoriesItemSJ(from: $0) }
        
        
                
     //   self.comics = json["comics"].rawValue as? ComicsSJ
     //   self.events = json["events"].rawValue as? ComicsSJ
    //    self.series = json["series"].rawValue as? ComicsSJ
    //    self.stories = json["stories"].rawValue as? StoriesSJ

     
        
        
        let urlsJSONs = json["urls"].arrayValue
        self.urls = urlsJSONs.map { UrlSJ(from: $0) }
            
        }
    
    func securePath(path: String?) -> String {
        guard let path = path else { return "" }
        if path.hasPrefix("http://") {
            if let range = path.range(of: "http://") {
                var newPath = path
                newPath.removeSubrange(range)
                return "https://" + newPath
            }
        }
        return path
    }
    
}


//class ImageSJ {
//
//    var fileExtension: String?
//    var path: String?
//
//    convenience init(from json: JSON) {
//        self.init()
//        self.fileExtension = json["extention"].stringValue
//        self.path = json["path"].stringValue
//    }
//
//    func securePath(path: String?) -> String {
//        guard let path = path else { return "" }
//        if path.hasPrefix("http://") {
//            let range = path.range(of: "http://")
//            var newPath = path
//            newPath.removeSubrange(range!)
//            return "https://" + newPath
//        } else {
//            return path
//        }
//
//    }
//
//    public var url: URL? {
//        return URL(string: self.securePath(path: self.path) + "." + self.fileExtension!)
//    }
//}


class UrlSJ {
    var type: String?
    var url: String?
    
    convenience init(from json: JSON) {
        self.init()
        self.type = json["type"].stringValue
        self.url = json["url"].stringValue

    }
}

//class ComicsSJ {
//    var available, returned: Int?
//    var collectionURI: String?
//    var items: [ComicsItemSJ]?
//
//    convenience init(from json: JSON) {
//        self.init()
//        self.available = json["available"].intValue
//        self.returned = json["returned"].intValue
//        self.collectionURI = json["collectionURI"].stringValue
//
//        let comicsItemsJSONs = json["items"].arrayValue
//        self.items = comicsItemsJSONs.map { ComicsItemSJ(from: $0)  }
//    }
//}

// MARK: - ComicsItem
class ComicsItemSJ {
    var resourceURI: String?
    var name: String?
    
    convenience init(from json: JSON) {
        self.init()
        self.resourceURI = json["resourceURI"].stringValue
        self.name = json["name"].stringValue
    }
}

//class EventsSJ {
//    var available, returned: Int?
//    var collectionURI: String?
//    var items: [ComicsItemSJ]?
//    
//    convenience init(from json: JSON) {
//        self.init()
//        self.available = json["available"].intValue
//        self.returned = json["returned"].intValue
//        self.collectionURI = json["collectionURI"].stringValue
//
//        let comicsItemsJSONs = json["items"].arrayValue
//        self.items = comicsItemsJSONs.map { ComicsItemSJ(from: $0)  }
//    }
//}



// MARK: - Stories
//class StoriesSJ {
//    var available, returned: Int?
//    var collectionURI: String?
//    var items: [StoriesItemSJ]?
//
//    convenience init(from json: JSON) {
//        self.init()
//        self.available = json["available"].intValue
//        self.returned = json["returned"].intValue
//        self.collectionURI = json["collectionURI"].stringValue
//
//        let storiesItemsJSONs = json["stories"]["items"].arrayValue
//        self.items = storiesItemsJSONs.map { StoriesItemSJ(from: $0)  }
//    }
//}

// MARK: - StoriesItem
class StoriesItemSJ {
    var resourceURI, name, type: String?
    convenience init(from json: JSON) {
        self.init()
        self.resourceURI = json["resourceURI"].stringValue
        self.name = json["name"].stringValue
        self.type = json["type"].stringValue

    }
}


//extension JSON {
//    public var date: Date? {
//        get {
//            if let str = self.string {
//                return JSON.jsonDateFormatter.date(from: str)
//            }
//            return nil
//        }
//    }
//
//    private static let jsonDateFormatter: DateFormatter = {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
//        return dateFormatter
//    }()
//}
