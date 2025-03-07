//
//  CryptoRouter.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire

enum ExchangeRouter: URLRequestConvertible {
    case ticker
    
    var baseURL: URL {
        guard let url = URL(string: ExternalDatasource.exchange.baseURLString) else {
            fatalError("[Router] baseURL error")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .ticker : return "/v1/ticker/all"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case .ticker : return [
            "quote_currencies":"KRW"
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
