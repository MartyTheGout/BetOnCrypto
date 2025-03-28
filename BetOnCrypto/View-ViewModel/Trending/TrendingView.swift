//
//  SearchView.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/8/25.
//

import UIKit

final class TrendingView: BaseView {
    
    let searchField = CustomSearchField()
    
    lazy var coinCollectionView = UICollectionView(frame: .zero, collectionViewLayout: create2X7CompositionalLayout())
    lazy var nftCollectionView = UICollectionView(frame: .zero, collectionViewLayout: create1X5CompositionalLayout())
    
    
    private let coinIntroductionContainer = {
        let view = UIView()
        view.backgroundColor = DesignSystem.Color.Renewal.tint.inUIColor()
        return view
    }()
    
    private let coinIntroductionLabel = {
        let label = UILabel()
        label.text = "떠오르는 가상화폐 "
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = DesignSystem.Color.Background.main.inUIColor()
        return label
    }()
    
    private let nftIntroductionContainer = {
        let view = UIView()
        view.backgroundColor = DesignSystem.Color.Renewal.tint.inUIColor()
        return view
    }()
    
    private let nftIntroductionLabel = {
        let label = UILabel()
        label.text = "이목을 끄는 NFT"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = DesignSystem.Color.Background.main.inUIColor()
        return label
    }()
    
    let fetchingTimeInfoLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = "03.08 00:40기준"
        label.textColor = DesignSystem.Color.Tint.submain.inUIColor()
        return label
    }()
    
    override func configureViewHierarchy() {
        [searchField, coinIntroductionContainer, fetchingTimeInfoLabel, coinCollectionView, nftIntroductionContainer, nftCollectionView ].forEach {
            addSubview($0)
        }
        
        coinIntroductionContainer.addSubview(coinIntroductionLabel)
        nftIntroductionContainer.addSubview(nftIntroductionLabel)
        
    }
    
    override func configureViewConstraints() {
        searchField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(8)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        coinIntroductionContainer.snp.makeConstraints {
            $0.top.equalTo(searchField.snp.bottom).offset(8)
            $0.leading.equalTo(safeAreaLayoutGuide)
        }
        
        coinIntroductionLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        fetchingTimeInfoLabel.snp.makeConstraints {
            $0.top.equalTo(searchField.snp.bottom).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        coinCollectionView.snp.makeConstraints {
            $0.top.equalTo(coinIntroductionLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide)
//            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(350)
        }
        
        nftIntroductionContainer.snp.makeConstraints {
            $0.top.equalTo(coinCollectionView.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide)
        }
        
        nftIntroductionLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        nftCollectionView.snp.makeConstraints {
            $0.top.equalTo(nftIntroductionLabel.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(150)
        }
    }
    
    override func configureViewDetails() {
        backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        
        nftCollectionView.backgroundColor = DesignSystem.Color.Background.segment.inUIColor()
        coinCollectionView.backgroundColor = DesignSystem.Color.Background.segment.inUIColor()
        
        coinIntroductionContainer.backgroundColor = DesignSystem.Color.Renewal.tint.inUIColor()
        
        nftIntroductionContainer.backgroundColor = DesignSystem.Color.Renewal.tint.inUIColor()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        coinIntroductionContainer.layer.cornerRadius = coinIntroductionContainer.frame.height / 2
        coinIntroductionContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        nftCollectionView.layer.cornerRadius = 10
        nftCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        coinCollectionView.layer.cornerRadius = 10
        coinCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        nftIntroductionContainer.layer.cornerRadius = coinIntroductionContainer.frame.height / 2
        nftIntroductionContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
}

extension TrendingView {
    
    private func create2X7CompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/7))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
            
            let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1.0))
            let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerGroupSize, subitems: [item])
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [innerGroup])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        })
        return layout
    }
    
    private func create1X5CompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
            
            let innerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let innerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: innerGroupSize, subitems: [item])
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4.5), heightDimension: .absolute(150))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [innerGroup])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        })
        
        return layout
    }
}
