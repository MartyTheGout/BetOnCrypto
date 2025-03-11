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
    
    static var mock = MarketPresentable(
        originalCoin : "KRW-BTC",
        presentableCoin: "BTC/KRW",
        originalPrice : 1212121212.0,
        presentablePrice: "111,111,111",
        originalPercentage: 0.5,
        presentablePercentage: "50%",
        originalDiff : 50.0,
        presentableDiff : "50.0",
        originalTotalAmount: 1212121212,
        presentableTotalAmount: "1212백만"
    )
}

final class MarketViewModel {
    private let designatedQueue = DispatchQueue(label: "MarketDataFetching_Queue")
    
    private let dataRepository = MarketDataRepository()
    
    private let disposeBag = DisposeBag()
    
    private var fetchingFlag = true // for start/stop in designated queue's infinit 5 sec work
    
    struct Input {
        let fetchDataRequest : BehaviorRelay<Void> = BehaviorRelay(value: ()) //For refetching data
        let currentPriceSortTab : ControlEvent<Void>
        let dayToDaySortTab : ControlEvent<Void>
        let totalAmountSortTab : ControlEvent<Void>
        let autoFetchRegistration : PublishRelay<Bool>
    }
    
    struct Output {
        let marketDataSeq : Driver<[MarketPresentable]>
        let sortingOptionSeq: Driver<SortingCriteria>
        let errorMessageSeq: Driver<String>
    }
    
    private var fetchDataRequest: BehaviorRelay<Void>?
    
    func transform(_ input : Input) -> Output {
        
        self.fetchDataRequest = input.fetchDataRequest
        
        let marketDataRelay: BehaviorRelay<[MarketPresentable]> = BehaviorRelay(value: [])
        let sortingRelay = BehaviorRelay(value: SortingCriteria.totalAmount(option: .none))
        let errorMessageRelay = PublishRelay<String>()
        
        input.autoFetchRegistration.bind(with: self) { owner, isOn in
            if isOn {
                owner.registerFetchingQueue()
            } else {
                owner.deRegisterFetchingQueue()
            }
        }.disposed(by: disposeBag)
        
        input.fetchDataRequest.bind(with: self) { owner, _ in
            let currentSortingCriteria = sortingRelay.value
            
            //For testing
//            owner.dataRepository.getTickerMock { data in
//                let sorted = owner.getSortedMarketData(with: currentSortingCriteria, on: data)
//                marketDataRelay.accept(sorted)
//            }
            
            owner.dataRepository.getTickerData { data in
                let sorted = owner.getSortedMarketData(with: currentSortingCriteria, on: data)
                marketDataRelay.accept(sorted)
            } errorMessageFeeder: { error in
                errorMessageRelay.accept(error)
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
            sortingOptionSeq: sortingRelay.asDriver(),
            errorMessageSeq: errorMessageRelay.asDriver(onErrorJustReturn: "")
        )
    }
}

extension MarketViewModel {
    private func registerFetchingQueue() {
        fetchingFlag = true
        designatedQueue.async { [weak self] in
            while (self?.fetchingFlag == true) {
                self?.fetchDataRequest?.accept(())
                sleep(5)
            }
        }
    }
    
    private func deRegisterFetchingQueue() {
        fetchingFlag = false
    }
    
    private func sortingHandler(
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
    
    private func getSortedMarketData(with sortingCriteria : SortingCriteria, on marketData: [MarketPresentable]) -> [MarketPresentable] {
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
