//
//  CharacterDetailViewModel.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 07.03.2021.
//

import Foundation

class CharacterDetailViewModel {
    
    let networkService = NetworkService()
    var loadStorySJ = [AnyStoryProtocol]()
    var characterSJ: CharacterSJ?
    var isLoading: Bool = false
    var activity: TypeOfStory = .comics
    
    func loadCharacterStoriesSJ(id: Int, storyType: TypeOfStory, limit: Int, offset: Int, completion: @escaping (String?) -> ()) {
        networkService.getCharacterAnyStorySJ(id: id, storyType: storyType, limit: limit, offset: offset)  { [weak self] result in
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
                guard let stories = data.data?.results else {
                    completion("Error: No data returned")
                    #if DEBUG
                    print("Error: No data returned")
                    #endif
                    return
                }
               
                guard let characterSJ = self.characterSJ else { return }
                
                switch storyType {
                case .comics:
                    if let characterSJ = self.characterSJ { try? RealmService.saveComics(item: characterSJ, stories: stories) }
                    self.loadStorySJ = characterSJ.comicsSJ
                case .events:
                    if let characterSJ = self.characterSJ { try? RealmService.saveEvents(item: characterSJ, stories: stories) }
                    self.loadStorySJ = characterSJ.eventsSJ
                case .series:
                    if let characterSJ = self.characterSJ { try? RealmService.saveSeries(item: characterSJ, stories: stories) }
                    self.loadStorySJ = characterSJ.seriesSJ
                case .stories:
                    if let characterSJ = self.characterSJ { try? RealmService.saveStories(item: characterSJ, stories: stories) }
                    self.loadStorySJ = characterSJ.storiesSJ
                }
                completion(nil)
                #if DEBUG
                print("Loading successfully complete")
                #endif
            case .failure(let error):
                let errorText = error.localizedDescription.split(separator: ":").last
                completion(errorText?.description)
                #if DEBUG
                print("Error: \(error.localizedDescription)")
                #endif
            }
        }
    }
    
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

