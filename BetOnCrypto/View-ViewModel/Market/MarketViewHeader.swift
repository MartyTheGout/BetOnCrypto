//
//  MarketViewHeader.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation

import UIKit

final class MarketHeader: BaseView {
    
    let containerView = CollectionListRegularForm()
    
    let coinColumnLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .black)
        label.text = "코인"
        label.textAlignment = .left
        return label
    }()
    
    let currentPriceSortingButton = SortingButton(title: "현재가")
    let dayToDaySortingButton = SortingButton(title: "전일대비")
    let totalAmountSortingButton = SortingButton(title: "거래대금")
    
    override func configureViewHierarchy() {
        addSubview(containerView)
        
        [coinColumnLabel, currentPriceSortingButton, dayToDaySortingButton, totalAmountSortingButton].forEach {
            containerView.addArrangedSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        coinColumnLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        
        currentPriceSortingButton.snp.makeConstraints {
            $0.width.equalTo(80)
        }
        
        dayToDaySortingButton.snp.makeConstraints {
            $0.width.equalTo(60)
        }
        
        totalAmountSortingButton.snp.makeConstraints {
            $0.width.equalTo(100)
        }
    }
    
    override func configureViewDetails() {
        backgroundColor = DesignSystem.Color.Background.segment.inUIColor()
    }
    
    func applyChangedSortingData(with sortingData: SortingCriteria) {
        switch sortingData {
        case .currentPrice(let option):
            applyChangeToCorrespondingButton(correspondingOne: 0, option: option)
        case .dayToDay(let option):
            applyChangeToCorrespondingButton(correspondingOne: 1, option: option)
        case .totalAmount(let option):
            applyChangeToCorrespondingButton(correspondingOne: 2, option: option)
        }
    }
    
    func applyChangeToCorrespondingButton(correspondingOne: Int, option: SortingSubOption) {
        [currentPriceSortingButton, dayToDaySortingButton, totalAmountSortingButton].enumerated().forEach { index, button in
            if index == correspondingOne {
                button.reflectSortingData(option: option)
            } else {
                button.reflectSortingData(option: .none)
            }
        }
    }
}
