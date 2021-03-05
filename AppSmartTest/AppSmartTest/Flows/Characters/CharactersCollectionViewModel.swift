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
                
           //     print(data.code)
        
                guard data.code == 200 else {
                    completion("Error Return Code: \(String(describing: data.code))")
                    print("Error Return Code: \(String(describing: data.code))")
                    return
                }

                guard let characters = data.data?.results  else {
                    completion("No data returned")
                    print("No data returned")
                    return
                }

               self.charactersSJ.append(contentsOf: characters)
                
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
    
}

