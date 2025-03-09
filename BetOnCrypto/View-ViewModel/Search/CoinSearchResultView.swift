//
//  CoinSearchResultView.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit
import SnapKit

final class CoinSearchResultView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionListView())
    
    override func configureViewHierarchy() {
        [collectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    override func configureViewDetails() {
        collectionView.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
    }
}

extension CoinSearchResultView {
    
    private func createCollectionListView() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        configuration.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}
