//
//  CharactersCollectionViewModel.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import Foundation
import RealmSwift

class CharactersCollectionViewModel {
    
    private let networkService = NetworkService()
    var charactersSJ = [CharacterSJ]()
    var searchCharactersSJ = [CharacterSJ]()
    var isLoading: Bool = false
    var search: Bool = false
    var searchText = String()
    var searchTotal = Int()

    func loadCharactersSJ(limit: Int, offset: Int, name: String? = nil, completion: @escaping (String?) -> ()) {
        networkService.getCharactersSJbyName(limit: limit, offset: offset, name: name)  { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                guard data.code == 200 else {
                    completion("Error Return Code: \(String(describing: data.code?.description))")
                    #if DEBUG
                    print("Error Return Code: \(String(describing: data.code?.description))")
                    #endif
                    return
                }
                guard let characters = data.data?.results  else {
                    completion("Error: No data returned")
                    #if DEBUG
                    print("Error: No data returned")
                    #endif
                    return
                }
                if name == nil {
                    guard let realm = try? Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true)) else { fatalError() }
                    self.search = false
                    try? realm.write {
                        self.charactersSJ.append(contentsOf: characters)
                        realm.add(self.charactersSJ, update: .modified)
                    }
                } else /*if let searchName = name, searchName != ""*/ {
                    if let total = data.data?.total {
                        self.searchTotal = total
                      //  print("Total = \(self.searchTotal)")
                    }
                    self.search = true
                    self.searchCharactersSJ.append(contentsOf: characters)
                 //   self.searchCharactersSJ = characters
                   // print(self.searchCharactersSJ)
                }
                completion(nil)
                #if DEBUG
                print("Loading successfully complete")
                #endif
            case .failure(let error):
                let errorText = error.localizedDescription.split(separator: ":").last
                completion(errorText?.description)
                #if DEBUG
                print(error.localizedDescription)
                #endif
            }
        }
    }
    
  /*  func loadCharactersSJByName(limit: Int, offset: Int, name: String, completion: @escaping (String?) -> ()) {
        networkService.getCharactersSJbyName(limit: limit, offset: offset, name: name)  { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                guard data.code == 200 else {
                    completion("Error Return Code: \(String(describing: data.code?.description))")
                    #if DEBUG
                    print("Error Return Code: \(String(describing: data.code?.description))")
                    #endif
                    return
                }
                guard let characters = data.data?.results  else {
                    completion("Error: No data returned")
                    #if DEBUG
                    print("Error: No data returned")
                    #endif
                    return
                }
                self.searchCharactersSJ = characters
                completion(nil)
                #if DEBUG
                print("Loading successfully complete")
                #endif
            case .failure(let error):
                completion(error.localizedDescription)
                #if DEBUG
                print("Error: \(error.localizedDescription)")
                #endif
                
            }
        }
    } */
    
    func createURL(fileExtension: String?, path: String?) -> URL? {
        func securePath(path: String?) -> String {
            guard let path = path else { return "" }
            if path.hasPrefix("http://") {
                let range = path.range(of: "http://")
                var newPath = path
                newPath.removeSubrange(range!)
                return "https://" + newPath
            } else { return path }
        }
        if fileExtension != "" && path != "" {
            if let fileExtension = fileExtension { return URL(string: securePath(path: path) + "." + fileExtension) }
        }
        return nil
    }
}

