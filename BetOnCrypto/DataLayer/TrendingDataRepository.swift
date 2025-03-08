//
//  ExchangeTickerRepository.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire

final class TrendingDataRepository {
//    func getTrendingData(dataFeeder : @escaping (_ with: [MarketPresentable]) -> Void) {
//        NetworkManager.shared.callRequest(ExchangeRouter.ticker) { [weak self] (result: Result<[MarketData], AFError>) in
//            switch result {
//            case .success(let marketData) :
//                let convertedData: [MarketPresentable] = marketData.map {
//                    self?.convertOriginToPresentable(with: $0) ?? MarketPresentable.mock
//                }
//                dataFeeder(convertedData)
//            case .failure(let error): print(error)
//            }
//        }
//    }
    
    func getTrendingMock(dataFeeder: @escaping (_ with: MockedSearchResult) -> Void) {
        dataFeeder(mockedSearchResult)
    }
}

extension TrendingDataRepository {

}
