//
//  SearchViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TrendingViewController : BaseViewController {
    
    private let viewModel = TrendingViewModel()
    
    private let mainView = TrendingView()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationTitleView()
        
        mainView.coinCollectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: CoinCollectionViewCell.id)
        bind()
    }
    
    private func configureNavigationTitleView() {
        let title = UILabel()
        title.text = "가상자산 / 심볼검색"
        title.font = .boldSystemFont(ofSize: 17)
        
        let spacer = UIView()
        let divider = Divider()
        
        let stack = UIStackView(arrangedSubviews: [title, spacer])
        stack.axis = .horizontal
        
        stack.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(500).priority(.low)
        }
        
        navigationItem.titleView = stack
        
        navigationController?.navigationBar.addSubview(divider)
        divider.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-1)
        }
    }
    
    override func configureViewDetails() {
        view.backgroundColor = .white
    }
    
    private func bind() {
        let input = TrendingViewModel.Input()
        let output = viewModel.transform(input)
        
        output.coinDataSeq.drive(mainView.coinCollectionView.rx.items(cellIdentifier: CoinCollectionViewCell.id, cellType: CoinCollectionViewCell.self)) { row, element, cell in
            dump(element)
            
            cell.applyData(with: element, number: row + 1)
            
        }.disposed(by: disposeBag)
        
        output.nftDataSeq.drive { value in
            dump("==== arrived from new === ")
            dump(value)
        }
    }
}
