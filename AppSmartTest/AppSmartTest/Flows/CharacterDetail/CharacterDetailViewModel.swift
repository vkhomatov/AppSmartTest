//
//  CharacterDetailViewModel.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 04.03.2021.
//

import Foundation
import RealmSwift


class CharacterDetailViewModel {
    
    let networkService = NetworkService()
    //var characters = [Character]()
   // var searchCharacters = [Character]()
    
    var loadStorySJ = [AnyStorySJ]()

    var characterSJ: CharacterSJ?

    
//    
//    init() {
//        
//        
//        
//    }
    
   // var storyArray = [[AnyStorySJ]]()
//    var comicsSJ = [AnyStorySJ]()
//    var eventsSJ = [AnyStorySJ]()
//    var seriesSJ = [AnyStorySJ]()
//    var storiesSJ = [AnyStorySJ]()
//
//
//    var loadStorySJ = [AnyStorySJ]()
   // var searchCharactersSJ = [CharacterSJ]()

    var isLoading: Bool = false
    
    var activity: TypeOfPActivity = .comics

 //   var search: Bool = false
    
//    func loadCharacters(limit: Int, offset: Int, completion: @escaping (String?) -> ()) {
//        self.isLoading = true
//        networkService.getResponse(limit: limit, offset: offset)  { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case let .success(data):
//
//                guard data.code == 200 else {
//                    completion("Error Return Code: \(String(describing: data.code))")
//                    return
//                }
//
//                guard let characters = data.data?.results else {
//                    completion("No data returned")
//                    return
//                }
//
//                self.characters.append(contentsOf: characters)
//                completion(nil)
//                self.isLoading = false
//
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//                completion(error.localizedDescription)
//            case .none:
//                completion("Unknown Error")
//                print("Unknown Error")
//
//            }
//        }
//
//    }
    
    func loadCharacterStoriesSJ(id: Int, storyType: String, limit: Int, offset: Int, completion: @escaping (String?) -> ()) {
     //   self.isLoading = true
        networkService.getCharacterAnyStorySJ(id: id, storyType: storyType, limit: limit, offset: offset)  { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                
        
//                guard data.code == 200 else {
//                    completion("Error Return Code: \(String(describing: data.code))")
//                    print("Error Return Code: \(String(describing: data.code))")
//                    return
//                }
//
//                guard let characters = data.data?.results  else {
//                    completion("No data returned")
//                    print("No data returned")
//                    return
//                }
                
                guard let characterSJ = self.characterSJ else { return }
//
                switch storyType {
                case "comics":
                    characterSJ.comicsSJ.append(contentsOf: data)
                    self.loadStorySJ = characterSJ.comicsSJ
                case "events":
                    characterSJ.eventsSJ.append(contentsOf: data)
                    self.loadStorySJ = characterSJ.eventsSJ
                case "series":
                    characterSJ.seriesSJ.append(contentsOf: data)
                    self.loadStorySJ = characterSJ.seriesSJ
                case "stories":
                    characterSJ.storiesSJ.append(contentsOf: data)
                    self.loadStorySJ = characterSJ.storiesSJ
                default:
                    break
                }
                
                
                completion(nil)
             //   self.isLoading = false
                print("Загрузка успешно завершена")
               // print(self.anyStorySJ)

                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(error.localizedDescription)
                
            }
            
        }
    }
    
    
}

enum TypeOfPActivity: String, CaseIterable {
    case comics = "comics", events = "events", series = "series", stories = "stories"

    func getIndex(num: Int)  -> TypeOfPActivity  {
        switch num {
        case 0:
           // loadStorySJ = comicsSJ

            return TypeOfPActivity.comics
        case 1:
            return TypeOfPActivity.events
        case 2:
            return TypeOfPActivity.series
        case 3:
            return TypeOfPActivity.stories
        default:
            return TypeOfPActivity.comics
        }

    }
}

