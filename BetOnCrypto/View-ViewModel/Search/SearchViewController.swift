//
//  SearchViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Toast

final class SearchViewController: BaseViewController {
    private var keyword : String
    
    private let viewModel = SearchViewModel()
    
    private let disposeBag = DisposeBag()
    
    private var childVC: UIViewController?
    
    private let noResultLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
        label.text = "검색어와 일치하는 코인이 없습니다.\n 다른 검색어를 입력해주세요."
        label.numberOfLines = 0
        return label
    }()
    
    init(keyword: String) {
        self.keyword = keyword
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainView = SearchView()
    
    private lazy var backBarButtonItem = {
        let button = UIBarButtonItem(image: DesignSystem.Icon.Info.back.toUIImage(), style: .plain, target: self, action: nil)
        button.tintColor = DesignSystem.Color.Tint.main.inUIColor()
        return button
    }()
    
    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.leftView = nil
        searchBar.searchTextField.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        searchBar.searchTextField.clearButtonMode = .never
        return searchBar
    }()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        searchBar.text = keyword
        configureSwipGestureHandler()
        
        mainView.coinSearchResultView.collectionView.register(CoinSearchResultViewCell.self, forCellWithReuseIdentifier: CoinSearchResultViewCell.id)
        
        
        bind()
        triggerDataStream()
    }
    
    private func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        
        searchBar.snp.makeConstraints {
            $0.width.equalTo(300)
        }
        
        self.navigationItem.leftBarButtonItems = [backBarButtonItem, UIBarButtonItem(customView: searchBar)]
    }
    
    private func bind() {
        
        let input = SearchViewModel.Input(
            searchEnter: searchBar.rx.searchButtonClicked,
            searchKeyword: searchBar.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input)
        
        output.coinSearchResultSeq.drive(with: self) { owner, value in
            output.activityIndicatrControlSeq.accept(false)
            
            if value.isEmpty {
                owner.showNoResultLabel()
            } else {
                owner.deleteNoResultLabel()
            }
            
        }.disposed(by: disposeBag)
        
        output.coinSearchResultSeq.drive(mainView.coinSearchResultView.collectionView.rx.items(cellIdentifier: CoinSearchResultViewCell.id, cellType: CoinSearchResultViewCell.self)) { row, element, cell in
            cell.applyData(with: element)
            
            cell.likeButton.rx.tap.bind {
                input.likedInputSeq.accept(element)
            }.disposed(by: cell.disposeBag)
            
        }.disposed(by: disposeBag)
        
        mainView.coinSearchResultView.collectionView.rx.modelSelected(SearchCoinPresentable.self).bind(with: self) { owner, value in
            owner.navigateToDetailView(with: value.id)
        }.disposed(by: disposeBag)
        
        output.likeOutputSeq.drive(with: self) { owner, value in
            owner.showLikeToastMessage(with: value)
        }.disposed(by: disposeBag)
        
        output.activityIndicatrControlSeq.bind(with: self) { owner, value in
            // true => show indicator , false => delete indicator
            if value {
                owner.createSpinnerView()
            } else {
                owner.deleteSpinnerView()
            }
        }.disposed(by: disposeBag)
        
        mainView.segmentedControl.rx.selectedSegmentIndex.bind(with: self) { owner, value in
            owner.mainView.controlContentView(with: value)
        }.disposed(by: disposeBag)
        
        backBarButtonItem.rx.tap.bind(with: self) { owner, _ in
            owner.navigateToBackViewController()
        }.disposed(by: disposeBag)
        
        input.searchEnter.bind(with: self) { owner, _ in
            owner.searchBar.searchTextField.endEditing(true)
        }.disposed(by: disposeBag)
        
        output.errorMessageSeq.drive(with: self ) { owner, value in
            owner.showErrorToast(message: value)
        }.disposed(by: disposeBag)
    }
}

// MARK: - Data Stream related
extension SearchViewController {
    private func triggerDataStream() {
        searchBar.searchTextField.sendActions(for: .editingDidEndOnExit)
    }
    
    private func showNoResultLabel() {
        mainView.coinSearchResultView.collectionView.addSubview(noResultLabel)
        noResultLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func deleteNoResultLabel() {
        if noResultLabel.superview != nil {
            noResultLabel.removeFromSuperview()
        }
    }
}

//MARK: - Swip Gesture related
extension SearchViewController {
    private func configureSwipGestureHandler() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        let index = mainView.segmentedControl.selectedSegmentIndex
        let maxIndex = mainView.segmentedControl.numberOfSegments - 1
        
        if gesture.direction == .left, index < maxIndex {
            mainView.segmentedControl.selectedSegmentIndex += 1
            mainView.segmentedControl.sendActions(for: .valueChanged)
            
        } else if gesture.direction == .right, index > 0 {
            mainView.segmentedControl.selectedSegmentIndex -= 1
            mainView.segmentedControl.sendActions(for: .valueChanged)
        }
    }
    
    private func navigateToBackViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    private func navigateToDetailView(with keyword: String) {
        let destinationVC = DetailViewController(keyword: keyword)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

//MARK: - Activity Indicator
extension SearchViewController {
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


//MARK: - Toast Message
extension SearchViewController {
    private func showLikeToastMessage(with value : String) {
        mainView.makeToast(value, duration: 0.65)
    }
    
    private func showErrorToast(message: String) {
        mainView.makeToast(message, duration: 0.65, position: .top)
    }
}
