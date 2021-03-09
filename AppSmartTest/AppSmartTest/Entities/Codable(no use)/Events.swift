//
//  Events.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import Foundation

// MARK: - EventsResponce
struct EventsResponce: Codable {
    let code, status, copyright, attributionText: String
    let attributionHTML: String
    let data: DataClass
    let etag: String
}

// MARK: - DataClass
struct EventsDataClass: Codable {
    let offset, limit, total, count: String
    let results: [EventsResult]
}

// MARK: - Result
struct EventsResult: Codable {
    let id, title, resultDescription, resourceURI: String
    let urls: [URLElement]
    let modified, start, end: String
    let thumbnail: Thumbnail
    let comics: Comics
    let stories: Stories
    let series: Comics
    let characters, creators: Characters
    let next, previous: Next

    enum CodingKeys: String, CodingKey {
        case id, title
        case resultDescription = "description"
        case resourceURI, urls, modified, start, end, thumbnail, comics, stories, series, characters, creators, next, previous
    }
}

// MARK: - Next
struct Next: Codable {
    let resourceURI, name: String
}

