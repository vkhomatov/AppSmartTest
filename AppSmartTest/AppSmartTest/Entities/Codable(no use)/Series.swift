//
//  Series.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import Foundation


// MARK: - SeriesResponce
struct SeriesResponce: Codable {
    let code, status, copyright, attributionText: String
    let attributionHTML: String
    let data: SeriesDataClass
    let etag: String
}

// MARK: - DataClass
struct SeriesDataClass: Codable {
    let offset, limit, total, count: String
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id, title, resultDescription, resourceURI: String
    let urls: [URLElement]
    let startYear, endYear, rating, modified: String
    let thumbnail: Thumbnail
    let comics: Comics
    let stories: Stories
    let events: Comics
    let characters, creators: Characters
    let next, previous: Next

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, urls, startYear, endYear, rating, modified, thumbnail, comics, stories, events, characters, creators, next, previous
    }
}
