//
//  MarketView.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit
import SnapKit

final class MarketView: BaseView {
    
    let header = MarketHeader()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createCollectionListView())
    
    override func configureViewHierarchy() {
        [header, collectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        header.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureViewDetails() {
        collectionView.backgroundColor = .systemIndigo
    }
}

extension MarketView {
    func createCollectionListView() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        configuration.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
}
