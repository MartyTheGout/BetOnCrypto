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
    var liked : Bool = false
}

struct DetailLike {
    let id : String
    let name: String
}

final class DetailViewModel {
    
    private let repository = CoinDataRepository()
    
    private var notificationToken : NotificationToken?
    
    private let disposeBag = DisposeBag()
    
    deinit {
        print("[DetailViewModel Deinit] Realm:NotificationToken also deinit")
        notificationToken?.invalidate()
    }
    
    struct Input {
        let coinId : String
        let likeInputSeq = PublishRelay<DetailLike>()
    }
    
    struct Output {
        let detailDataSeq: Driver<CoinDetailPresentable?>
        let likeOutputSeq: Driver<String>
    }
    
    func transform(_ input : Input) -> Output {
        let detailDataRelay = BehaviorRelay<CoinDetailPresentable?>(value: nil)
        let likeOutputRelay = PublishRelay<String>()
        
        let likedDataSeq = BehaviorRelay<[String]>(value: [])
        makeRealmDataSeq(in: likedDataSeq)
        
        likedDataSeq.distinctUntilChanged().bind { ids in
            let currentDetail = detailDataRelay.value
            
            if var currentDetail {
                let updatedLikedData = ids.contains(currentDetail.id)
                currentDetail.liked = updatedLikedData
                detailDataRelay.accept(currentDetail)
            }
            
        }.disposed(by: disposeBag)
        
        repository.getCoinDetail(id: input.coinId) { detailConverted in
            let liked = likedDataSeq.value.contains(detailConverted.id)
            
            var forLikeContainingDetail = detailConverted
            forLikeContainingDetail.liked = liked
            
            detailDataRelay.accept(forLikeContainingDetail)
        }
        
        input.likeInputSeq.bind(with: self) { owner, detailLike in
            let currentLiked = likedDataSeq.value.contains(detailLike.id)
            
            if currentLiked {
                owner.repository.deleteLikeRecords(of: LikedCoin(id: detailLike.id))
                likeOutputRelay.accept("\(detailLike.name)이 즐겨찾기에서 제거되었습니다.")
            } else {
                owner.repository.addLikeRecords(of: LikedCoin(id: detailLike.id))
                likeOutputRelay.accept("\(detailLike.name)이 즐겨찾기되었습니다.")
            }
            
        }.disposed(by: disposeBag)
        
        return Output(
            detailDataSeq: detailDataRelay.asDriver(),
            likeOutputSeq: likeOutputRelay.asDriver(onErrorJustReturn: "'즐겨찾기' 에러가 발생했습니다. 담당자에게 문의해주세요.")
        )
    }
}

extension DetailViewModel {
    private func makeRealmDataSeq(in relay: BehaviorRelay<[String]>) {
        
        let likedCoinRecords = repository.getLikeRecords()
        
        notificationToken = likedCoinRecords.observe { changes in
            switch changes {
            case .initial(let results) :
                let array = Array(results)
                relay.accept(array.map { $0.id })
                print("Repository Observe : inital")
            case .update(let results, _, _, _) :
                let array = Array(results)
                relay.accept(array.map { $0.id })
                print("Repository Observe : update")
            case .error(let error) :
                print("[Error]repository observer failed", error)
            }
        }
    }
}
