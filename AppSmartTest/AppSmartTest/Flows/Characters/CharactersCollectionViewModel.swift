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
    //var characters = [Character]()
   // var searchCharacters = [Character]()
    
    var charactersSJ = [CharacterSJ]()
    var searchCharactersSJ = [CharacterSJ]()

    var isLoading: Bool = false
    //var isTVLoading: Bool = false

    var search: Bool = false
    
    
//    var comicsSJ = [AnyStorySJ]()
//    var eventsSJ = [AnyStorySJ]()
//    var seriesSJ = [AnyStorySJ]()
//    var storiesSJ = [AnyStorySJ]()
//    
//    var characterSJ: CharacterSJ?
//
//    
//    
//    var loadStorySJ = [AnyStorySJ]()
   // var searchCharactersSJ = [CharacterSJ]()

  //  var isLoading: Bool = false
    
  //  var activity: TypeOfPActivity = .comics
    
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
    
    func loadCharactersSJ(limit: Int, offset: Int, completion: @escaping (String?) -> ()) {
      //  self.isLoading = true
        networkService.getCharactersSJ(limit: limit, offset: offset)  { [weak self] result in
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
//
                self.charactersSJ.append(contentsOf: data)
                
                completion(nil)
            //    self.isLoading = false
                print("Загрузка успешно завершена")
             //   print(self.charactersSJ)

                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                completion(error.localizedDescription)
                
            }
            
        }
    }
    
    
//    func loadCharacterStoriesSJ(id: Int, storyType: String, limit: Int, offset: Int, completion: @escaping (String?) -> ()) {
//     //   self.isLoading = true
//        networkService.getCharacterAnyStorySJ(id: id, storyType: storyType, limit: limit, offset: offset)  { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case let .success(data):
//
//
////                guard data.code == 200 else {
////                    completion("Error Return Code: \(String(describing: data.code))")
////                    print("Error Return Code: \(String(describing: data.code))")
////                    return
////                }
////
////                guard let characters = data.data?.results  else {
////                    completion("No data returned")
////                    print("No data returned")
////                    return
////                }
////
//                switch storyType {
//                case "comics":
//                    self.comicsSJ.append(contentsOf: data)
//                    self.loadStorySJ = self.comicsSJ
//                case "events":
//                    self.eventsSJ.append(contentsOf: data)
//                    self.loadStorySJ = self.eventsSJ
//                case "series":
//                    self.seriesSJ.append(contentsOf: data)
//                    self.loadStorySJ = self.seriesSJ
//                case "stories":
//                    self.storiesSJ.append(contentsOf: data)
//                    self.loadStorySJ = self.storiesSJ
//                default:
//                    break
//                }
//
//
//                completion(nil)
//             //   self.isLoading = false
//                print("Загрузка успешно завершена")
//               // print(self.anyStorySJ)
//
//
//            case .failure(let error):
//                print("Error: \(error.localizedDescription)")
//                completion(error.localizedDescription)
//
//            }
//
//        }
//    }
//
    
    
}

//enum TypeOfPActivity: String, CaseIterable {
//    case comics = "comics", events = "events", series = "series", stories = "stories"
//
//    func getIndex(num: Int)  -> TypeOfPActivity  {
//        switch num {
//        case 0:
//           // loadStorySJ = comicsSJ
//
//            return TypeOfPActivity.comics
//        case 1:
//            return TypeOfPActivity.events
//        case 2:
//            return TypeOfPActivity.series
//        case 3:
//            return TypeOfPActivity.stories
//        default:
//            return TypeOfPActivity.comics
//        }
//
//    }
//}
