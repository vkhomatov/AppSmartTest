//
//  Character.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 02.03.2021.
//

import Foundation



// MARK: - Response
struct MarvellResponse: Codable {
    let code: Int?
    let status, copyright, attributionText: String?
    let attributionHTML: String?
    let data: DataClass?
    let etag: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [Character]?
}

// MARK: - Character
struct Character: Codable  {
    let id: Int?
    let name, characterDescription, modified: String?
    let resourceURI: String?
    let urls: [URLElement]?
    let thumbnail: Thumbnail?
    let comics: Comics?
    let stories: Stories?
    let events, series: Comics?

    enum CodingKeys: String, CodingKey {
        case id, name
        case characterDescription = "description"
        case modified, resourceURI, urls, thumbnail, comics, stories, events, series
    }
    
//    var names: [String.SubSequence]? {
//        get {
//         return self.name?.split(separator: " ")
//        }
//    }
}

// MARK: - Comics
struct Comics: Codable {
    let available, returned: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI, name: String?
}

// MARK: - Stories
struct Stories: Codable {
    let available, returned: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI, name, type: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    
    let thumbnailExtension: String?
    let path: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
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
    
    public var url: URL? {
        return URL(string: self.securePath(path: self.path) + "." + self.thumbnailExtension!)
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type, url: String?
}
