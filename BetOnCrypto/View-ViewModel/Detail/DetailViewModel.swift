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

final class DetailViewModel {
    
    private let repository = CoinDataRepository()
    
    struct Input {
        let coinId : String
    }
    
    struct Output {
        let detailDataSeq: Driver<CoinDetail?>
    }
    
    func transform(_ input : Input) -> Output {
        
        let detailDataRelay = BehaviorRelay<CoinDetail?>(value: nil)
        
        repository.getDetailMock { coinDetail in
            detailDataRelay.accept(coinDetail)
        }
        
        return Output(
            detailDataSeq: detailDataRelay.asDriver()
        )
    }
}
