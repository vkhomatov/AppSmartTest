//
//  RealmService.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 05.03.2021.
//

import Foundation
import RealmSwift

class RealmService {
    
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    static func get(_ type: CharacterSJ.Type,
                    configuration: Realm.Configuration = deleteIfMigration,
                    update: Realm.UpdatePolicy = .modified)
    throws -> [CharacterSJ] {
        let realm = try Realm(configuration: configuration)
        #if DEBUG
        print("Realm \(String(describing: configuration.fileURL?.description))" )
        #endif
        return realm.objects(type).map { $0 }.sorted { $0.name ?? "" < $1.name ?? "" }
    }
    
    static func save(item: CharacterSJ, segment: Int = 0,
                     configuration: Realm.Configuration = deleteIfMigration,
                     update: Realm.UpdatePolicy = .modified)
    throws {
        let realm = try Realm(configuration: configuration)
        #if DEBUG
        print("Realm \(String(describing: configuration.fileURL?.description))" )
        #endif
        try realm.write {
            item.segment = segment
            realm.add(item.self, update: update)
        }
    }
    
    static func saveComics(item: CharacterSJ, stories: [AnyStoryProtocol],
                           configuration: Realm.Configuration = deleteIfMigration,
                           update: Realm.UpdatePolicy = .modified)
    throws {
        let realm = try Realm(configuration: configuration)
        #if DEBUG
        print("Realm \(String(describing: configuration.fileURL?.description))" )
        #endif
        try realm.write {
            item.comicsSJ.append(contentsOf: stories)
            realm.add(item, update: update)
        }
    }
    
    static func saveEvents(item: CharacterSJ, stories: [AnyStoryProtocol],
                           configuration: Realm.Configuration = deleteIfMigration,
                           update: Realm.UpdatePolicy = .modified)
    throws {
        let realm = try Realm(configuration: configuration)
        #if DEBUG
        print("Realm \(String(describing: configuration.fileURL?.description))" )
        #endif
        try realm.write {
            item.eventsSJ.append(contentsOf: stories)
            realm.add(item, update: update)
        }
    }
    
    static func saveSeries(item: CharacterSJ, stories: [AnyStoryProtocol],
                           configuration: Realm.Configuration = deleteIfMigration,
                           update: Realm.UpdatePolicy = .modified)
    throws {
        let realm = try Realm(configuration: configuration)
        #if DEBUG
        print("Realm \(String(describing: configuration.fileURL?.description))" )
        #endif
        try realm.write {
            item.seriesSJ.append(contentsOf: stories)
            realm.add(item, update: update)
        }
    }
    
    static func saveStories(item: CharacterSJ, stories: [AnyStoryProtocol],
                            configuration: Realm.Configuration = deleteIfMigration,
                            update: Realm.UpdatePolicy = .modified)
    throws {
        let realm = try Realm(configuration: configuration)
        #if DEBUG
        print("Realm \(String(describing: configuration.fileURL?.description))" )
        #endif
        try realm.write {
            item.storiesSJ.append(contentsOf: stories)
            realm.add(item, update: update)
        }
    }
    
}

