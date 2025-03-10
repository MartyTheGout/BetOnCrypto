//
//  CryptoRouter.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire

enum CoinAndNFTRouter: URLRequestConvertible {
    case trending
    case search(query: String)
    case detail(id: String)
    
    var baseURL: URL {
        guard let url = URL(string: ExternalDatasource.search.baseURLString) else {
            fatalError("[Router] baseURL error")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .trending : return "/api/v3/search/trending"
        case .search: return "/api/v3/search"
        case .detail: return "/api/v3/coins/markets"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .trending : return [:]
        case .search(let query) : return [
            "query": query
        ]
        case .detail(let id) : return [
            "vs_currency":"krw",
            "ids": id,
            "sparkline": "true"
        ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.method = .get
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
