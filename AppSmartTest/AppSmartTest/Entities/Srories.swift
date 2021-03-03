//
//  Srories.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import Foundation


// MARK: - StoriesResponce
struct StoriesResponce: Codable {
    let code, status, copyright, attributionText: String
    let attributionHTML: String
    let data: StoriesDataClass
    let etag: String
}

// MARK: - DataClass
struct StoriesDataClass: Codable {
    let offset, limit, total, count: String
    let results: [StoriesResult]
}

// MARK: - Result
struct StoriesResult: Codable {
    let id, title, resultDescription, resourceURI: String
    let type, modified: String
    let thumbnail: Thumbnail
    let comics, series, events: Comics
    let characters, creators: Characters
    let originalissue: Originalissue

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, type, modified, thumbnail, comics, series, events, characters, creators, originalissue
    }
}

// MARK: - Originalissue
struct Originalissue: Codable {
    let resourceURI, name: String
}
