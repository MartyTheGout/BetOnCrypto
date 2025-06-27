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
import Toast

final class MarketViewController : BaseViewController {
    
    private let viewModel = MarketViewModel()
    private let disposeBag = DisposeBag()
    private let autoFetchRegistration = PublishRelay<Bool>()
    
    private let mainView = MarketView()
    private var childVC: UIViewController?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.collectionView.register(MarketCollectionViewCell.self, forCellWithReuseIdentifier: MarketCollectionViewCell.id)
        
        configureNavigationTitleView()
        
        createSpinnerView()
        bind()
    }
    
    // MarketView fetches data from external datasource, every 5 sec.
    // when viewWillAppear called, 5 sec fetching-loop is registered
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        autoFetchRegistration.accept(true)
    }
    
    // when viewWillDisappear called, 5 sec fetching-loop is de-registered
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        autoFetchRegistration.accept(false)
    }
    
    private func configureNavigationTitleView() {
        let title = UILabel()
        title.text = "Market"
        title.font = .boldSystemFont(ofSize: 21)
        
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
            $0.bottom.equalToSuperview().offset(-1)
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func bind() {
        let input = MarketViewModel.Input(
            currentPriceSortTab: mainView.header.currentPriceSortingButton.rx.tap,
            dayToDaySortTab: mainView.header.dayToDaySortingButton.rx.tap,
            totalAmountSortTab: mainView.header.totalAmountSortingButton.rx.tap,
            autoFetchRegistration: autoFetchRegistration
        )
        
        let output = viewModel.transform(input)
        
        output.marketDataSeq.drive(mainView.collectionView.rx.items(cellIdentifier: MarketCollectionViewCell.id, cellType: MarketCollectionViewCell.self)) { row, element, cell in
            cell.configureData(basedOn: element)
            
        }.disposed(by: disposeBag)
        
        output.marketDataSeq.filter { !$0.isEmpty }.asObservable().take(1)
        //            .do(onDispose: {
        //                    print("Subscription disposed!")
        //                }) // possible to use 'do' to check whether dispose work has completely done.
            .bind(with: self) { owner, value in
                owner.deleteSpinnerView()
            }.disposed(by: disposeBag)
        
        output.sortingOptionSeq.drive(with: self) { owner, value in
            owner.mainView.header.applyChangedSortingData(with: value)
        }.disposed(by: disposeBag)
        
        output.errorMessageSeq.drive(with: self ) { owner, value in
            owner.showErrorToast(message: value)
        }.disposed(by: disposeBag)
        
    }
}

//MARK: - Activity Indicator
extension MarketViewController {
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
extension MarketViewController {
    private func showErrorToast(message: String) {
        mainView.makeToast(message, duration: 0.65, position: .top)
    }
}
