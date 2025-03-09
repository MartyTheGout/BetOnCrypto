//
//  SearchViewModel.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    let repository = SearchDataRepository()
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchEnter : ControlEvent<Void>
        let searchKeyword : ControlProperty<String>
    }
    
    struct Output {
        let coinSearchResultSeq : Driver<[SearchCoin]>
    }
    
    func transform(_ input : Input) -> Output {
        let coinSearchResultRelay : BehaviorRelay<[SearchCoin]> = BehaviorRelay(value: [])
        
        input.searchEnter.withLatestFrom(input.searchKeyword).bind(with: self) { owner, value in
            print("input recognized, searchViewModel", value)
            owner.repository.getCoinWithKeyword(keyword: value) { value in
                coinSearchResultRelay.accept(value)
            }
        }.disposed(by: disposeBag)
        
        return Output(coinSearchResultSeq: coinSearchResultRelay.asDriver())
    }
}
