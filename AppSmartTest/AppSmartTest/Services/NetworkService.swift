//
//  NetworkService.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 07.03.2021.
//

import Foundation
import Alamofire
import CryptoSwift
import SwiftyJSON

class NetworkService {
    
    var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "gateway.marvel.com"
        return constructor
    }()
    
    static let session: Alamofire.Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 20
        //        config.urlCredentialStorage = nil
        //        config.timeoutIntervalForResource = 100
        //        config.httpAdditionalHeaders = ["" : ""]
        let session = Alamofire.Session(configuration: config)
        return session
    }()
    
    func getCharactersSJbyName(limit: Int, offset: Int, name: String? = nil, completion: ((Swift.Result<ResponceSJ, Error>) -> Void)? = nil) {
        
        urlConstructor.path = "/v1/public/characters"
        let ts = Date().timeIntervalSince1970.description
        var params: Parameters
        
        switch name  {
        case nil:
                params = [
                "apikey": SessionKey.shared.publicKey,
                "ts": ts,
                "hash": (ts + SessionKey.shared.privateKey + SessionKey.shared.publicKey).md5(),
                "orderBy": "name",
                "limit" : limit,
                "offset" : offset ]
        default:
                guard let name = name else { return }
                params = [
                "apikey": SessionKey.shared.publicKey,
                "ts": ts,
                "hash": (ts + SessionKey.shared.privateKey + SessionKey.shared.publicKey).md5(),
                "nameStartsWith": name,
                "orderBy": "name",
                "limit" : limit,
                "offset" : offset ]
        }
        
        guard let url = urlConstructor.url else { return }
        NetworkService.session.request(url, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(data):
                let json = JSON(data)
                let response = ResponceSJ(from: json)
                  completion?(.success(response))
            case let .failure(error):
                completion?(.failure(error))
                #if DEBUG
                print(#function + " - Data load error: \(error)")
                #endif
            }
        }
    }
    
    func getCharacterAnyStorySJ(id: Int, storyType: TypeOfStory, limit: Int, offset: Int, completion: ((Swift.Result<AnyStoryResponseProtocol, Error>) -> Void)? = nil) {
        
        urlConstructor.path = "/v1/public/characters"+"/"+String(id)+"/"+storyType.rawValue
        let ts = Date().timeIntervalSince1970.description
        let params: Parameters = [
            "apikey": SessionKey.shared.publicKey,
            "ts": ts,
            "hash": (ts + SessionKey.shared.privateKey + SessionKey.shared.publicKey).md5(),
            "orderBy": "-modified",
            "limit" : limit,
            "offset" : offset ]
        
        guard let url = urlConstructor.url else { return }
        
        NetworkService.session.request(url, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(data):
                let json = JSON(data)

                switch storyType {
                case .comics:
                    let response = ResponceComicSJ(from: json)
                    completion?(.success(response))
                case .events:
                    let response = ResponceEventSJ(from: json)
                    completion?(.success(response))
                case .series:
                    let response = ResponceSeriesSJ(from: json)
                    completion?(.success(response))
                case .stories:
                    let response = ResponceStoriesSJ(from: json)
                    completion?(.success(response))
                }
    
            case let .failure(error):
                completion?(.failure(error))
                #if DEBUG
                print(#function + " - Data load error: \(error)")
                #endif
            }
        }
    }
    
}
