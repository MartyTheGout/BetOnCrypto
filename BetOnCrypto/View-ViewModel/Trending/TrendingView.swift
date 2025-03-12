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
    
    private let coinIntroductionLabel = {
        let label = UILabel()
        label.text = "인기 검색어"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
        return label
    }()
    
    private let nftIntroductionLabel = {
        let label = UILabel()
        label.text = "인기 NFT"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
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
        [searchField, coinIntroductionLabel, fetchingTimeInfoLabel, coinCollectionView, nftIntroductionLabel, nftCollectionView ].forEach {
            addSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        searchField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        coinIntroductionLabel.snp.makeConstraints {
            $0.top.equalTo(searchField.snp.bottom).offset(24)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        fetchingTimeInfoLabel.snp.makeConstraints {
            $0.top.equalTo(searchField.snp.bottom).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
        }
        
        coinCollectionView.snp.makeConstraints {
            $0.top.equalTo(coinIntroductionLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(350)
        }
        
        nftIntroductionLabel.snp.makeConstraints {
            $0.top.equalTo(coinCollectionView.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        nftCollectionView.snp.makeConstraints {
            $0.top.equalTo(nftIntroductionLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(150)
        }
    }
    
    override func configureViewDetails() {
        backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        
        nftCollectionView.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        coinCollectionView.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
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
