//
//  DetailViewControler.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class DetailViewController: BaseViewController {
    
    private var keyword : String
    
    private let viewModel = DetailViewModel()
    
    private let disposeBag = DisposeBag()
    
    private let mainView = DetailView()
    
    private lazy var backBarButtonItem = {
        let button = UIBarButtonItem(image: DesignSystem.Icon.Info.back.toUIImage(), style: .plain, target: self, action: nil)
        button.tintColor = DesignSystem.Color.Tint.main.inUIColor()
        return button
    }()
    
    private lazy var likeButtonItem = {
        let button = UIBarButtonItem(image: DesignSystem.Icon.Input.star.toUIImage(), style: .plain, target: self, action: nil)
        button.tintColor = DesignSystem.Color.Tint.main.inUIColor()
        return button
    }()
    
    private lazy var navTitleView = UIView()
    
    private let titleImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel = UILabel()
    
    init(keyword: String) {
        self.keyword = keyword
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        bind()
    }
    
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationItem.rightBarButtonItem = likeButtonItem
        navigationItem.titleView = navTitleView
    }
    
    override func configureViewHierarchy() {
        [titleImageView, titleLabel].forEach { navTitleView.addSubview($0)}
    }
    
    override func configureViewConstraints() {
        titleImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.width.equalTo(titleImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleImageView.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-4)
        }
    }
    
    override func configureViewDetails() {
        titleLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    func bind() {
        let input = DetailViewModel.Input(coinId: keyword)
        let output = viewModel.transform(input)
        
        output.detailDataSeq.drive(with: self) { owner, coinDetail in
            if let coinDetail {
                owner.mainView.applyData(with: coinDetail)
                owner.reflectDataOnTitle(with: coinDetail)
            }
        }.disposed(by: disposeBag)
        
        backBarButtonItem.rx.tap.bind(with: self) { owner, _ in
            owner.navigateToBackViewController()
        }.disposed(by: disposeBag)
        
        likeButtonItem.rx.tap.withLatestFrom(output.detailDataSeq)
            .compactMap { coinDetail in coinDetail }
            .bind(with: self) { owner, value in
            input.likeInputSeq.accept(DetailLike(id: value.id, name: value.name))
        }.disposed(by: disposeBag)
        
        output.likeOutputSeq.drive(with: self) { owner, value in
            owner.showLikeToastMessage(with: value)
        }.disposed(by: disposeBag)
    }
}

extension DetailViewController {
    private func reflectDataOnTitle(with data: CoinDetailPresentable) {
        titleLabel.text = data.symbol.uppercased()
        
        titleImageView.kf.setImage(with: URL(string: data.image))
        titleImageView.layer.cornerRadius = titleImageView.frame.height / 2
        
        let likeSymbol = data.liked ?  DesignSystem.Icon.Input.star.fill() : DesignSystem.Icon.Input.star.toUIImage()
        
        likeButtonItem.image = likeSymbol
    }
    
    private func navigateToBackViewController() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Toast Message
extension DetailViewController {
    private func showLikeToastMessage(with value : String) {
        mainView.makeToast(value, duration: 0.65)
    }
}
