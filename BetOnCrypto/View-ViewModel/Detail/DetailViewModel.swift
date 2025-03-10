//
//  DetailViewModel.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/10/25.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

struct CoinDetailPresentable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: String
    let priceChangePercentage24h: String
    let marketCap: String
    let fullyDilutedValuation: String
    let totalVolume: String
    let high24h: String
    let low24h: String
    let ath: String
    let athDate: String
    let atl: String
    let atlDate: String
    let lastUpdated: String
    let sparklineIn7d: [Double]?
}

final class DetailViewModel {
    
    private let repository = CoinDataRepository()
    
    struct Input {
        let coinId : String
    }
    
    struct Output {
        let detailDataSeq: Driver<CoinDetailPresentable?>
    }
    
    func transform(_ input : Input) -> Output {
        print("given input", input.coinId)
        let detailDataRelay = BehaviorRelay<CoinDetailPresentable?>(value: nil)
        
//        repository.getDetailMock { coinDetail in
//            detailDataRelay.accept(coinDetail)
//        }
        
        repository.getCoinDetail(id: input.coinId) { detailConverted in
            dump(detailConverted)
            detailDataRelay.accept(detailConverted)
        }
        
        return Output(
            detailDataSeq: detailDataRelay.asDriver()
        )
    }
}


