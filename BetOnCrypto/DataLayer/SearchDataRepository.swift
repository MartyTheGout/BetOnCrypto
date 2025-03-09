//
//  ExchangeTickerRepository.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire

final class SearchDataRepository {
    func getCoinWithKeyword(
        keyword: String,
        dataFeeder : @escaping ([SearchCoin]) -> Void
    ) {
        NetworkManager.shared.callRequest(CoinAndNFTRouter.search(query: keyword)) {(result: Result<SearchResult, AFError>) in
            switch result {
            case .success(let searchResult) :
                dataFeeder(searchResult.coins)
            case .failure(let error): print(error)
            }
        }
    }
    
    func getTrendingMock(dataFeeder: @escaping ([SearchCoin]) -> Void) {
        dataFeeder(mockSearchCoin)
    }
}
