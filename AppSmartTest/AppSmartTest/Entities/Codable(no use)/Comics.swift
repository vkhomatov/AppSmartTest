//
//  Comics.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import Foundation

// MARK: - ComicsResponce
struct ComicsResponce: Codable {
    let code, status, copyright, attributionText: String
    let attributionHTML: String
    let data: ComicsDataClass
    let etag: String
}

// MARK: - DataClass
struct ComicsDataClass: Codable {
    let offset, limit, total, count: Int?
    let results: [ComicsResult]
}

// MARK: - Result
struct ComicsResult: Codable {
    let id, digitalID : Int?
    let title: String?
    let issueNumber: Double?
    let variantDescription, resultDescription, isbn: String?
    let modified: Date?
    let upc, diamondCode, ean, issn: String
    let format: String
    let pageCount: Int?
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [URLElement]
    let series: Series
    let variants, collections, collectedIssues: [Series]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators, characters: Characters
    let stories: Stories
    let events: Events

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription
        case resultDescription = "description"
        case modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
    }
}

// MARK: - Characters
struct Characters: Codable {
    let available, returned: Int?
    let collectionURI: String?
    let items: [CharactersItem]
}

// MARK: - CharactersItem
struct CharactersItem: Codable {
    let resourceURI, name, role: String?
}

// MARK: - Series
struct Series: Codable {
    let resourceURI, name: String?
}

// MARK: - DateElement
struct DateElement: Codable {
    let type, date: String?
}

// MARK: - Events
struct Events: Codable {
    let available, returned: Int?
    let collectionURI: String?
    let items: [Series]
}

// MARK: - TextObject
struct TextObject: Codable {
    let type, language, text: String
}

// MARK: - Price
struct Price: Codable {
    let type, price: String
}

