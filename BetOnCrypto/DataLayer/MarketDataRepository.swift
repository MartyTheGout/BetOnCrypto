//
//  ExchangeTickerRepository.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire

final class MarketDataRepository {
    func getTickerData(dataFeeder : @escaping (_ with: [MarketData]) -> Void) {
        NetworkManager.shared.callRequest(ExchangeRouter.ticker) { (result: Result<[MarketData], AFError>) in
            switch result {
            case .success(let marketData) : dataFeeder(marketData)
            case .failure(let error): print(error)
            }
        }
    }
}
