//
//  Router.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire

enum SearchRouter : URLRequestConvertible {
    case search
    case trending
    
    var baseURL: URL {
        guard let url = URL(string: ExternalDatasource.search.baseURLString) else {
            fatalError("[Router] baseURL error")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .search: return "/api/v3/coins/markets"
        case .trending: return "/api/v3/search/trending"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .search : return [
            "vs_currency":"krw"
        ]
        case .trending: return [:]
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
