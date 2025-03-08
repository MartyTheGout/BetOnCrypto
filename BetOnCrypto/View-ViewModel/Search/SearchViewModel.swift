//
//  SearchViewModel.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/8/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    private let designatedQueue = DispatchQueue(label: "TrendingDataFetching_Qeue")
    
    private let dataRepository = TrendingDataRepository()
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let fetchDataRequest : BehaviorRelay<Void> = BehaviorRelay(value: ()) //For refetching data
    }
    
    struct Output {
        let coinDataSeq: Driver<[SearchCoin]>
        let nftDataSeq : Driver<[SearchNFT]>
    }
    
    private var fetchDataRequest: BehaviorRelay<Void>?
    
    private let coinRelay: BehaviorRelay<[SearchCoin]> = BehaviorRelay(value: [])
    private let nftRelay: BehaviorRelay<[SearchNFT]> = BehaviorRelay(value: [])
    
    func transform(_ input: Input) -> Output {
        
        self.fetchDataRequest = input.fetchDataRequest
        
        registerFetchingQueue()
        
        input.fetchDataRequest.bind(with: self) { owner, _ in
            owner.dataRepository.getTrendingMock { result in
                print(result)
                owner.coinRelay.accept(result.coins)
                owner.nftRelay.accept(result.nfts)
            }

        }.disposed(by: disposeBag)
        
        return Output(
            coinDataSeq: coinRelay.asDriver(),
            nftDataSeq: nftRelay.asDriver()
        )
    }
}

extension SearchViewModel {
    private func registerFetchingQueue() {
        designatedQueue.async {
            while(true) {
                print("registerFetch- from search")
                self.fetchDataRequest?.accept(())
                sleep(600)
            }
        }
    }
}
