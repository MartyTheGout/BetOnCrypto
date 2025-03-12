//
//  SearchView.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit
import SnapKit

final class SearchView : BaseView {
    let segmentedControl = UnderlinedSegmentedControl(items: ["코인","NFT","거래소"])
    
    let coinSearchResultView = CoinSearchResultView()
    private let nftSearchResultView = InPreparingView()
    private let exchangeResultView = InPreparingView()
    
    override func configureViewHierarchy() {
        [segmentedControl, coinSearchResultView, nftSearchResultView, exchangeResultView].forEach{
            addSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        segmentedControl.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        coinSearchResultView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        nftSearchResultView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        exchangeResultView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureViewDetails() {
        backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        
        segmentedControl.setTitleTextAttributes([
            .foregroundColor: DesignSystem.Color.Tint.submain.inUIColor()
        ], for: .normal)
        
        segmentedControl.setTitleTextAttributes(
            [
                .foregroundColor: DesignSystem.Color.Tint.main.inUIColor(),
                .font: UIFont.systemFont(ofSize: 13, weight: .bold)
            ],
            for: .selected
        )
        segmentedControl.selectedSegmentIndex = 0
    }
}

extension SearchView {
    func controlContentView(with segmentIndex: Int) {
        [coinSearchResultView, nftSearchResultView, exchangeResultView].enumerated().forEach { index, view in
            if segmentIndex == index {
                view.isHidden = false
            } else {
                view.isHidden = true
            }
        }
    }
}
