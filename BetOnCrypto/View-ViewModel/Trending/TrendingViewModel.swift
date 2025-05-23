//
//  SearchViewModel.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/8/25.
//

import Foundation
import RxSwift
import RxCocoa

struct TrendingCoinPresentable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    let data: TrendingCoinDataPresentable
}

struct TrendingCoinDataPresentable {
    let krw: String
}

struct TrendingNFTPresentable {
    let name: String
    let thumb: String
    let floorPrice24hPercentageChange: String
    let data: TrendingNFTDataPresentable
}

struct TrendingNFTDataPresentable: Codable {
    let floorPrice: String
}

final class TrendingViewModel {
    
    private let designatedQueue = DispatchQueue(label: "TrendingDataFetching_Qeue")
    
    private let dataRepository = TrendingDataRepository()
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let fetchDataRequest : BehaviorRelay<Void> = BehaviorRelay(value: ()) //For refetching data
    }
    
    struct Output {
        let coinDataSeq: Driver<[TrendingCoinPresentable]>
        let nftDataSeq : Driver<[TrendingNFTPresentable]>
        let errorMessageSeq: Driver<String>
    }
    
    private var fetchDataRequest: BehaviorRelay<Void>?
    
    private let coinRelay: BehaviorRelay<[TrendingCoinPresentable]> = BehaviorRelay(value: [])
    private let nftRelay: BehaviorRelay<[TrendingNFTPresentable]> = BehaviorRelay(value: [])
    
    func transform(_ input: Input) -> Output {
        
        self.fetchDataRequest = input.fetchDataRequest
        
        let errorMessageRelay = PublishRelay<String>()
        
        registerFetchingQueue()
        
        input.fetchDataRequest.bind(with: self) { owner, _ in
            //            owner.dataRepository.getTrendingMock { mockCoin, mockNft in
            //                owner.coinRelay.accept(mockCoin.suffix(14))
            //                owner.nftRelay.accept(mockNft.suffix(7))
            //            }
            
            owner.dataRepository.getTrendingData { coinData, nftData in
                owner.coinRelay.accept(coinData.suffix(14))
                owner.nftRelay.accept(nftData.suffix(7))
            } errorMessageFeeder: { errorMessage in
                errorMessageRelay.accept(errorMessage)
            }
        }.disposed(by: disposeBag)
        
        return Output(
            coinDataSeq: coinRelay.asDriver(),
            nftDataSeq: nftRelay.asDriver(),
            errorMessageSeq: errorMessageRelay.asDriver(onErrorJustReturn: "")
        )
    }
}

extension TrendingViewModel {
    private func registerFetchingQueue() {
        designatedQueue.async {
            while(true) {
                self.fetchDataRequest?.accept(())
                sleep(600)
            }
        }
    }
}
