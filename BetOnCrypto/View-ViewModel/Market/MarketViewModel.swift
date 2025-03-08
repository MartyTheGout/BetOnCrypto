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
    
    func changeSubOption() -> SortingCriteria {
        switch self {
        case .currentPrice(let option): return .currentPrice(option: option.next())
        case .dayToDay(let option): return .dayToDay(option: option.next())
        case .totalAmount(let option): return .totalAmount(option: option.next())
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
            let currentSortingCriteria = sortingRelay.value
            
            owner.dataRepository.getTickerMock { data in
                let sorted = owner.getSortedMarketData(with: currentSortingCriteria, on: data)
                marketDataRelay.accept(sorted)
            }
            
        }.disposed(by: disposeBag)
        
        input.currentPriceSortTab.bind(with: self) { owner, _ in
            owner.sortingHandler(sortingRelay: sortingRelay, marketDataRelay: marketDataRelay, selectedSortingOption: SortingCriteria.currentPrice(option: .descendent)) { sortingCriteria in
                if case .currentPrice = sortingCriteria {
                    return true
                }
                return false
            }
            
        }.disposed(by: disposeBag)
        
        input.dayToDaySortTab.bind(with: self) { owner, _ in
            owner.sortingHandler(sortingRelay: sortingRelay, marketDataRelay: marketDataRelay, selectedSortingOption: SortingCriteria.dayToDay(option: .descendent)) { sortingCriteria in
                if case .dayToDay = sortingCriteria {
                    return true
                }
                return false
            }
        }.disposed(by: disposeBag)
        
        input.totalAmountSortTab.bind(with: self) { owner, _ in
            owner.sortingHandler(sortingRelay: sortingRelay, marketDataRelay: marketDataRelay, selectedSortingOption: SortingCriteria.totalAmount(option: .descendent)) { sortingCriteria in
                if case .totalAmount = sortingCriteria {
                    return true
                }
                return false
            }
        }.disposed(by: disposeBag)
        
        return Output(
            marketDataSeq: marketDataRelay.asDriver(),
            sortingOptionSeq: sortingRelay.asDriver()
        )
    }
}

extension MarketViewModel {
    func registerFetchingQueue() {
        designatedQueue.async {
            while (true) {
                self.fetchDataRequest?.accept(())
                sleep(5)
            }
        }
    }
    
    func sortingHandler(
        sortingRelay: BehaviorRelay<SortingCriteria>,
        marketDataRelay: BehaviorRelay<[MarketPresentable]>,
        selectedSortingOption : SortingCriteria,
        isSameSortingOption : (SortingCriteria) -> Bool
    ) {
        let currentSortingOption: SortingCriteria = sortingRelay.value
        let currentMarketData : [MarketPresentable] = marketDataRelay.value
        
        var newSortingCriteria: SortingCriteria
        
        if isSameSortingOption(currentSortingOption) {
            newSortingCriteria = currentSortingOption.changeSubOption()
        } else {
            newSortingCriteria = selectedSortingOption
        }
        
        sortingRelay.accept(newSortingCriteria)
        let sortedData = getSortedMarketData(with: newSortingCriteria, on: currentMarketData)
        marketDataRelay.accept(sortedData)
        
    }
    
    func getSortedMarketData(with sortingCriteria : SortingCriteria, on marketData: [MarketPresentable]) -> [MarketPresentable] {
        switch sortingCriteria {
        case .currentPrice(let option):
            switch option  {
            case .none:
                return marketData.sorted { previous, next in
                    previous.originalTotalAmount > next.originalTotalAmount
                }
            case .ascendent:
                return marketData.sorted { previous, next in
                    previous.originalPrice < next.originalPrice
                }
            case .descendent:
                return marketData.sorted { previous, next in
                    previous.originalPrice > next.originalPrice
                }
            }
        case .dayToDay(let option):
            switch option  {
            case .none:
                return marketData.sorted { previous, next in
                    previous.originalTotalAmount > next.originalTotalAmount
                }
            case .ascendent:
                return marketData.sorted { previous, next in
                    previous.originalPercentage < next.originalPercentage
                }
            case .descendent:
                return marketData.sorted { previous, next in
                    previous.originalPercentage > next.originalPercentage
                }
            }
        case .totalAmount(let option):
            switch option  {
            case .none:
                return marketData.sorted { previous, next in
                    previous.originalTotalAmount > next.originalTotalAmount
                }
            case .ascendent:
                return marketData.sorted { previous, next in
                    previous.originalTotalAmount < next.originalTotalAmount
                }
            case .descendent:
                return marketData.sorted { previous, next in
                    previous.originalTotalAmount > next.originalTotalAmount
                }
            }
        }
    }
}
