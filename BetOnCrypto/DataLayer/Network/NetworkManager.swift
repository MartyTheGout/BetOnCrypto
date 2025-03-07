//
//  NetworkManager.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func callRequest<T: Codable>(
        _ requestContent: URLRequestConvertible,
        completionHandler: @escaping (Result<T, AFError>) -> Void
    ) {
        AF.request(requestContent).responseDecodable(of: T.self) { response in
            completionHandler(response.result)
        }
    }
}

