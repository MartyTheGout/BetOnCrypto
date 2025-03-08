//
//  MarketViewModel.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import RxSwift
import RxCocoa

enum SortingCriteria {
    case currentPrice(option: SortingSubOption)
    case dayToDay(option: SortingSubOption)
    case totalAmount(option: SortingSubOption)
    
    func getSubOption() -> Int {
        switch self {
        case .currentPrice(let option): return option.rawValue
        case .dayToDay(let option): return option.rawValue
        case .totalAmount(let option): return option.rawValue
        }
    }
}

enum SortingSubOption: Int {
    case none = 0
    case descendent
    case ascendent
    
    func next() -> SortingSubOption {
        return SortingSubOption(rawValue: (self.rawValue + 1) % 3) ?? .none
    }
}

struct MarketPresentable {
    var originalCoin : String
    var presentableCoin: String
    var originalPrice : Double
    var presentablePrice: String
    var originalPercentage: Double
    var presentablePercentage: String
    var originalDiff : Double
    var presentableDiff : String
    var originalTotalAmount: Double
    var presentableTotalAmount: String
}

class MarketViewModel {
    let designatedQueue = DispatchQueue(label: "MarketDataFetching_Queue")
    
    let dataRepository = MarketDataRepository()
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let fetchDataRequest : BehaviorRelay<Void> = BehaviorRelay(value: ()) //For refetching data
        let currentPriceSortTab : ControlEvent<Void>
        let dayToDaySortTab : ControlEvent<Void>
        let totalAmountSortTab : ControlEvent<Void>
    }
    
    struct Output {
        let marketDataSeq : Driver<[MarketPresentable]>
        let sortingOptionSeq: Driver<SortingCriteria>
    }
    
    var fetchDataRequest: BehaviorRelay<Void>?
    
    func transform(_ input : Input) -> Output {
        
        self.fetchDataRequest = input.fetchDataRequest
        
        let marketDataRelay: BehaviorRelay<[MarketPresentable]> = BehaviorRelay(value: [])
        let sortingRelay = BehaviorRelay(value: SortingCriteria.totalAmount(option: .none))
        
        input.fetchDataRequest.bind(with: self) { owner, _ in
            owner.dataRepository.getTickerMock { data in
                marketDataRelay.accept(data)
            }
            
        }.disposed(by: disposeBag)
        
        return Output(
            marketDataSeq: marketDataRelay.asDriver(),
            sortingOptionSeq: sortingRelay.asDriver()
        )
    }
    
    func registerFetchingQueue() {
        designatedQueue.async {
            while (true) {
                self.fetchDataRequest?.accept(())
                sleep(5)
            }
        }
    }
}
