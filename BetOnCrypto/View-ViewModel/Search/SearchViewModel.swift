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
        let likedInputSeq = PublishRelay<SearchCoinPresentable>()
    }
    
    struct Output {
        let coinSearchResultSeq : Driver<[SearchCoinPresentable]>
        let activityIndicatrControlSeq: BehaviorRelay<Bool>
        let likeOutputSeq: Driver<String>
        let errorMessageSeq: Driver<String>
    }
    
    func transform(_ input : Input) -> Output {
        let coinSearchResultRelay : BehaviorRelay<[SearchCoinPresentable]> = BehaviorRelay(value: [])
        let activityIndicatrControlSeq: BehaviorRelay<Bool> = BehaviorRelay(value: true)
        let likeOutputRelay = PublishRelay<String>()
        
        repository.printRepositorySandBox()// for debugging
        
        let likedDataSeq = BehaviorRelay<Set<String>>(value: [])
        makeRealmDataSeq(in: likedDataSeq)
        
        let errorMessageRelay = PublishRelay<String>()
        
        input.searchEnter.withLatestFrom(input.searchKeyword).distinctUntilChanged()
            .bind(with: self) { owner, value in
                let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
                
                guard trimmedValue.count > 0 else {
                    print("유효한 검색어가 아닙니다.")
                    return
                }
                
                activityIndicatrControlSeq.accept(true)
                
                owner.repository.getCoinWithKeyword(keyword: value) { value in
                    let convertedOne = value.map { searchCoin in
                        let likedOrNot = likedDataSeq.value.contains(searchCoin.id)
                        return owner.convertOriginalToPresentable(of: searchCoin, likedOrNot: likedOrNot)
                    }
                    coinSearchResultRelay.accept(convertedOne)
                } errorMessageFeeder: { errorMessage in
                    errorMessageRelay.accept(errorMessage)
                }
                
                // to-point-index : not set, but likedDataArray => O(n) + O(m), 시간 복잡도
                
//                let likedDataIndex = 0
                
//                owner.repository.getCoinWithKeyword(keyword: value) { value in
//                    let convertedOne = value.map { searchCoin in
                
//                      while likedDataSeq[likedDataIndex] < searchCoin.id && likedDataIndex < likedDataSeq.count - 1 {
//                         likedDataSeq += 1
//                       }
                
//                        let likedOrNot = searchCoin.id == likedDataSeq[likedDataIndex]
//                        return owner.convertOriginalToPresentable(of: searchCoin, likedOrNot: likedOrNot)
//                    }
//                    coinSearchResultRelay.accept(convertedOne)
//                } errorMessageFeeder: { errorMessage in
//                    errorMessageRelay.accept(errorMessage)
//                }
            
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
            if likedDataSeq.value.contains(value.id) {
                owner.repository.deleteLikeRecords(of: LikedCoin(id: value.id))
                likeOutputRelay.accept("\(value.name)이 즐겨찾기에서 제거되었습니다.")
            }else {
                owner.repository.addLikeRecords(of: LikedCoin(id: value.id))
                likeOutputRelay.accept("\(value.name)이 즐겨찾기되었습니다.")
            }
            
        }.disposed(by: disposeBag)
        
        return Output(
            coinSearchResultSeq: coinSearchResultRelay.asDriver(),
            activityIndicatrControlSeq: activityIndicatrControlSeq,
            likeOutputSeq: likeOutputRelay.asDriver(onErrorJustReturn: "'즐겨찾기' 에러가 발생했습니다. 담당자에게 문의해주세요."),
            errorMessageSeq: errorMessageRelay.asDriver(onErrorJustReturn: "")
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
    func makeRealmDataSeq(in relay : BehaviorRelay<Set<String>>) {
        let likedCoinRecords = repository.getLikeRecords()
        
        notificationToken = likedCoinRecords.observe { changes in
            switch changes {
            case .initial(let results):
                let set: Set<String> = Set(Array(results).map {$0.id})
                relay.accept(set)
            case .update(let results, _, _, _) :
                let set: Set<String> = Set(Array(results).map {$0.id})
                relay.accept(set)
            case .error(let error) :
                print("[Error]repository observer failed", error)
            }
        }
    }
}
