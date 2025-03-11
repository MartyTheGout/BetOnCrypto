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
    
    private var childVC : UIViewController?
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationTitleView()
        
        mainView.coinCollectionView.register(CoinCollectionViewCell.self, forCellWithReuseIdentifier: CoinCollectionViewCell.id)
        mainView.nftCollectionView.register(NFTCollectionViewCell.self, forCellWithReuseIdentifier: NFTCollectionViewCell.id)
        
        createSpinnerView()
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
        
        output.coinDataSeq.filter { !$0.isEmpty }.asObservable().take(1)
//            .do(
//                onDispose: {
//                    print("TrendingViewController:coinDataSeq:onceSubscription || disposed completely")
//                }
//            )
            .bind(with: self) { owner, _ in
                owner.deleteSpinnerView()
            }
        .disposed(by: disposeBag)
        
        output.nftDataSeq.drive(mainView.nftCollectionView.rx.items(cellIdentifier: NFTCollectionViewCell.id, cellType: NFTCollectionViewCell.self)) { row, element, cell in
            cell.applyData(with: element)
        }.disposed(by: disposeBag)
        
        mainView.coinCollectionView.rx.modelSelected(TrendingCoinPresentable.self).bind(with: self) { owner, coinData in
            owner.navigateToDetailView(with: coinData.id)
        }.disposed(by: disposeBag)
        
        mainView.searchField.textField.rx.controlEvent(.editingDidEndOnExit)
            .withLatestFrom(mainView.searchField.textField.rx.text.orEmpty)
            .bind(with: self) { owner, text in
                owner.navigateToSearchView(with: text)
            }
            .disposed(by: disposeBag)
        
        output.errorMessageSeq.drive(with: self ) { owner, value in
            owner.showErrorToast(message: value)
        }.disposed(by: disposeBag)
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

extension TrendingViewController {
    private func createSpinnerView() {
        let child = SpinnerViewController()
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        self.childVC = child
        
        tabBarController?.tabBar.items?.forEach { $0.isEnabled = false }
    }
    
    private func deleteSpinnerView() {
        guard let childVC else {
            print("[MarketViewController] There is no childVC here")
            return
        }
        
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
        
        tabBarController?.tabBar.items?.forEach { $0.isEnabled = true }
        tabBarController?.selectedIndex = 1
        
        DispatchQueue.main.async {
            self.tabBarController?.tabBar.setNeedsLayout()
            self.tabBarController?.tabBar.layoutIfNeeded()
        }
    }
}

//MARK: - Toast
extension TrendingViewController {
    private func showErrorToast(message: String) {
        mainView.makeToast(message, duration: 0.65, position: .top)
    }
}
