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

class SearchViewController: BaseViewController {
    private var keyword : String
    
    let viewModel = SearchViewModel()
    
    let disposeBag = DisposeBag()
    
    var childVC: UIViewController?
    
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
    
    override func configureViewHierarchy() {}
    
    override func configureViewConstraints() {}
    
    override func configureViewDetails() {}
    
    private func bind() {
        
        let input = SearchViewModel.Input(
            searchEnter: searchBar.rx.searchButtonClicked,
            searchKeyword: searchBar.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input)
        
        output.coinSearchResultSeq.drive() { _ in
            output.activityIndicatrControlSeq.accept(false)
        }.disposed(by: disposeBag)
        
        output.coinSearchResultSeq.drive(mainView.coinSearchResultView.collectionView.rx.items(cellIdentifier: CoinSearchResultViewCell.id, cellType: CoinSearchResultViewCell.self)) { row, element, cell in
            cell.applyData(with: element)
            
            //TODO: Test Required
            cell.likeButton.rx.tap.bind {
                print("like99 called", element.id)
                input.likedInputSeq.accept(element.id)
            }.disposed(by: cell.disposeBag)
            
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
    }
}

// MARK: - Data Stream related
extension SearchViewController {
    private func triggerDataStream() {
        searchBar.searchTextField.sendActions(for: .editingDidEndOnExit)
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
