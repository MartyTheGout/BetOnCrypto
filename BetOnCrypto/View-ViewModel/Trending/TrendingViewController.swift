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
        mainView.nftCollectionView.register(NFTCollectionViewCell.self, forCellWithReuseIdentifier: NFTCollectionViewCell.id)
        
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
        
        output.coinDataSeq.drive(mainView.coinCollectionView.rx.items(cellIdentifier: CoinCollectionViewCell.id, cellType: CoinCollectionViewCell.self)) { [weak self] row, element, cell in
            cell.applyData(with: element, number: row + 1)
            self?.updateDataFetchingTime()
        }.disposed(by: disposeBag)
        
        output.nftDataSeq.drive(mainView.nftCollectionView.rx.items(cellIdentifier: NFTCollectionViewCell.id, cellType: NFTCollectionViewCell.self)) { row, element, cell in
            cell.applyData(with: element)
        }.disposed(by: disposeBag)
        
        mainView.coinCollectionView.rx.modelSelected(TrendingCoinPresentable.self).bind(with: self) { owner, coinData in
            print("item Selected")
            owner.navigateToDetailView(with: coinData.name)
        }.disposed(by: disposeBag)
        
        Observable.combineLatest(
            mainView.searchField.textField.rx.controlEvent(.editingDidEnd),
            mainView.searchField.textField.rx.text.orEmpty
        ).bind(with: self) { owner, combinedEvent in
            
        }
    }
}

extension TrendingViewController {
    private func updateDataFetchingTime() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd hh:mm기준"
        
        mainView.fetchingTimeInfoLabel.text =  dateFormatter.string(from: Date())
    }
    
    private func navigateToDetailView(with keyword: String) {
        let destinationVC = DetailViewController(keyword: keyword)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    private func navigateToSearchView(with keyword: String) {
        let destinationVC = SearchViewController(keyword: keyword)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
