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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //TODO: make 5sec fetch work, switch on
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //TODO: make 5sec fetch work, switch off
    }
    
    private func configureNavigationTitleView() {
        let title = UILabel()
        title.text = "거래소"
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
    
    private func bind() {
        let input = MarketViewModel.Input(
            currentPriceSortTab: mainView.header.currentPriceSortingButton.rx.tap,
            dayToDaySortTab: mainView.header.dayToDaySortingButton.rx.tap,
            totalAmountSortTab: mainView.header.totalAmountSortingButton.rx.tap
        )
        
        let output = viewModel.transform(input)
        
        output.marketDataSeq.drive(mainView.collectionView.rx.items(cellIdentifier: MarketCollectionViewCell.id, cellType: MarketCollectionViewCell.self)) { row, element, cell in
            cell.configureData(basedOn: element)
            
        }.disposed(by: disposeBag)
        
        output.marketDataSeq.filter { !$0.isEmpty}.asObservable().take(1)
//            .do(onDispose: {
//                    print("Subscription disposed!")
//                }) // possible to use 'do' to check whether dispose work has completely done.
            .bind(with: self) { owner, value in
            owner.deleteSpinnerView()
        }.disposed(by: disposeBag)
        
        output.sortingOptionSeq.drive(with: self) { owner, value in
            owner.mainView.header.applyChangedSortingData(with: value)
        }.disposed(by: disposeBag)

    }
}

extension MarketViewController {
    private func createSpinnerView() {
        let child = SpinnerViewController()

         addChild(child)
         child.view.frame = view.frame
         view.addSubview(child.view)
         child.didMove(toParent: self)
        
        self.childVC = child
    }
    
    private func deleteSpinnerView() {
        guard let childVC else {
            print("[MarketViewController] There is no childVC here")
            return
        }
        
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
}
