//
//  NetworkService.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 02.03.2021.
//

import Foundation
import Alamofire
import CryptoSwift


// сетевая сессия
class NetworkService {
    
//    let session: URLSession = {
//        let config = URLSessionConfiguration.default
//       // config.waitsForConnectivity = true
//       // config.timeoutIntervalForRequest = 30
//        config.urlCredentialStorage = nil
//        config.timeoutIntervalForResource = 100
//        config.httpAdditionalHeaders = ["app-key" : "12345", "v" : "1"]
//        return URLSession(configuration: config)
//    }()
    
    //[ base url: https://gateway.marvel.com , api version: Cable ]
    
    //http://gateway.marvel.com/v1/public/comics?ts=1&apikey=1234&hash=ffd275c5130566a2916217b101f26150
    
    
   // /v1/public/characters
    
    var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "gateway.marvel.com"
        return constructor
    }()
    
    static let session: Alamofire.Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        let session = Alamofire.Session(configuration: config)
        return session
    }()

    
    
    func getResponse(limit: Int, offset: Int, completion: @escaping (Swift.Result<MarvellResponse, Error>?) -> Void)  {

        urlConstructor.path = "/v1/public/characters"
//        urlConstructor.queryItems = [
//            URLQueryItem(name: "login", value: login),
//            URLQueryItem(name: "password", value: password)
//        ]
        
     //   let baseMarvelURL = "https://gateway.marvel.com/v1/public/comics"
        let ts = Date().timeIntervalSince1970.description
        
        let params: Parameters = [
            "apikey": SessionKey.shared.publicKey,
            "ts": ts,
            "hash": (ts + SessionKey.shared.privateKey + SessionKey.shared.publicKey).md5(),
            "orderBy": "-modified",
            "limit" : limit,
            "offset" : offset
        ]
        
        guard let url = urlConstructor.url else { return }
       // guard let query = urlConstructor.query else { return }
        
      //  var request = URLRequest(url: url)
       // request.httpMethod = "POST"
       // request.httpBody = Data(query.utf8)
        
        NetworkService.session.request(url, method: .get, parameters: params).responseData { response in
            switch response.result {
            case let .success(data):
                
             //   print("ОТВЕТ ОТ СЕРВЕРА ПОЛУЧЕН:\n")
               // print(data)
                
                
                if let marvellResponse = try? JSONDecoder().decode(MarvellResponse.self, from: data) {
                completion(.success(marvellResponse))
                    //print(#function + "ДАННЫЕ УСПЕШНО ЗАГРУЖЕНЫ")

                }

                
                
//
//                    do {
//                        let marvellResponse = try JSONDecoder().decode(MarvellResponse.self, from: data)
//                        completion(.success(marvellResponse))
//                    } catch let DecodingError.dataCorrupted(context) {
//                        print(context)
//                    } catch let DecodingError.keyNotFound(key, context) {
//                        print("Key '\(key)' not found:", context.debugDescription)
//                        print("codingPath:", context.codingPath)
//                    } catch let DecodingError.valueNotFound(value, context) {
//                        print("Value '\(value)' not found:", context.debugDescription)
//                        print("codingPath:", context.codingPath)
//                    } catch let DecodingError.typeMismatch(type, context)  {
//                        print("Type '\(type)' mismatch:", context.debugDescription)
//                        print("codingPath:", context.codingPath)
//                    } catch {
//                        print("error: ", error)
//                    }
                     

            case let .failure(error):
                completion(.failure(error))
                print(#function + "ОШИБКА ЗАГРУЗКИ ДАННЫХ \(error)")
                
            }
        }

     
    }
    
}
