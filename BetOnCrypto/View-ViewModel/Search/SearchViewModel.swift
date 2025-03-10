//
//  SearchViewModel.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

struct SearchCoinPresentable {
    let id: String
    let name: String
    let apiSymbol: String
    let symbol: String
    let marketCapRank: Int?
    let thumb: String
    let large: String
    var liked : Bool
}

final class SearchViewModel {
    
    private let repository = CoinDataRepository()
    
    private var notificationToken: NotificationToken?
    
    private let disposeBag = DisposeBag()
    
    deinit {
        print("[SearchViewModel Deinit] Realm:NotificationToken also deinit")
        notificationToken?.invalidate()
    }
    
    struct Input {
        let searchEnter : ControlEvent<Void>
        let searchKeyword : ControlProperty<String>
        let likedInputSeq = PublishRelay<String>()
    }
    
    struct Output {
        let coinSearchResultSeq : Driver<[SearchCoinPresentable]>
        let activityIndicatrControlSeq: BehaviorRelay<Bool>
    }
    
    func transform(_ input : Input) -> Output {
        let coinSearchResultRelay : BehaviorRelay<[SearchCoinPresentable]> = BehaviorRelay(value: [])
        let activityIndicatrControlSeq: BehaviorRelay<Bool> = BehaviorRelay(value: true)
        
        repository.printRepositorySandBox()// for debugging
        
        let likedDataSeq = BehaviorRelay<[String]>(value: [])
        makeRealmDataSeq(in: likedDataSeq)
        
        input.searchEnter.withLatestFrom(input.searchKeyword).distinctUntilChanged()
            .bind(with: self) { owner, value in
                activityIndicatrControlSeq.accept(true)
                owner.repository.getCoinWithKeyword(keyword: value) { value in
                    let convertedOne = value.map { searchCoin in
                        
                        let likedOrNot = likedDataSeq.value.contains(searchCoin.id)
                        
                        return owner.convertOriginalToPresentable(of: searchCoin, likedOrNot: likedOrNot)
                    }
                    
                    coinSearchResultRelay.accept(convertedOne)
                }
            }.disposed(by: disposeBag)
        
        likedDataSeq.bind(with: self) {owner, value in
            let currentSearchResult = coinSearchResultRelay.value
            let updateReflectedOne = currentSearchResult.map { coinResult in
                
                let likedOrnot = likedDataSeq.value.contains(coinResult.id)
                
                var updateReflected = coinResult
                updateReflected.liked = likedOrnot
                return updateReflected
            }
            
            coinSearchResultRelay.accept(updateReflectedOne)
        }.disposed(by: disposeBag)
        
        input.likedInputSeq.bind(with: self) { owner, value in
            if likedDataSeq.value.contains(value) {
                owner.repository.deleteLikeRecords(of: LikedCoin(id: value)) //TODO: Syntax check
            }else {
                owner.repository.addLikeRecords(of: LikedCoin(id: value))
            }
            
        }.disposed(by: disposeBag)
        
        return Output(
            coinSearchResultSeq: coinSearchResultRelay.asDriver(),
            activityIndicatrControlSeq: activityIndicatrControlSeq
        )
    }
}

extension SearchViewModel {
    func convertOriginalToPresentable(of data: SearchCoin, likedOrNot: Bool) -> SearchCoinPresentable {
        return SearchCoinPresentable(
            id: data.id,
            name: data.name,
            apiSymbol: data.apiSymbol,
            symbol: data.symbol,
            marketCapRank: data.marketCapRank,
            thumb: data.thumb,
            large: data.large,
            liked: likedOrNot
        )
    }
}

extension SearchViewModel {
    func makeRealmDataSeq(in relay : BehaviorRelay<[String]>) {
        let likedCoinRecords = repository.getLikeRecords()
        
        notificationToken = likedCoinRecords.observe { changes in
            switch changes {
            case .initial(let results):
                let array = Array(results)
                relay.accept(array.map { $0.id })
            case .update(let results, _, _, _) :
                let array = Array(results)
                relay.accept(array.map { $0.id })
            case .error(let error) :
                print("[Error]repository observer failed", error)
            }
        }
    }
}
