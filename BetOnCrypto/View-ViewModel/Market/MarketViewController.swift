//
//  CryptoExchangeViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MarketViewController : BaseViewController {
    
    private let viewModel = MarketViewModel()
    private let disposeBag = DisposeBag()
    
    private let mainView = MarketView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        mainView.collectionView.register(MarketCollectionViewCell.self, forCellWithReuseIdentifier: MarketCollectionViewCell.id)
    }
    
    func bind() {
        let input = MarketViewModel.Input(
            currentPriceSortTab: mainView.header.currentPriceSortingButton.rx.tap,
            dayToDaySortTab: mainView.header.dayToDaySortingButton.rx.tap,
            totalAmountSortTab: mainView.header.totalAmountSortingButton.rx.tap
        )
        
        let output = viewModel.transform(input)
        
        output.marketDataSeq.drive(mainView.collectionView.rx.items(cellIdentifier: MarketCollectionViewCell.id, cellType: MarketCollectionViewCell.self)) { row, element, cell in
            
            cell.configureData(basedOn: element)
            
        }.disposed(by: disposeBag)
        
        output.sortingOptionSeq.drive(with: self) { owner, value in
            owner.mainView.header.applyChangedSortingData(with: value)
        }.disposed(by: disposeBag)
    }
}
