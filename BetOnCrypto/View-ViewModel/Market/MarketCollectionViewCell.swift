//
//  MarketCollectionViewCell.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit
import SnapKit

class MarketCollectionViewCell: UICollectionViewCell {
    
    static var id : String {
        String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierarchy()
        configureViewConstraints()
        configureViewDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let listRegularFormat = CollectionListRegularForm()
    
    let coinLabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    let priceLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    let comparisonView = UIView()
    
    let percentageComparison = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    let absoluteComparison = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9)
        label.textAlignment = .right
        return label
    }()
    
    let amountLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    private func configureViewHierarchy() {
        contentView.addSubview(listRegularFormat)
        
        [coinLabel, priceLabel, comparisonView, amountLabel].forEach {
            listRegularFormat.addArrangedSubview($0)
        }
        
        [percentageComparison, absoluteComparison].forEach {
            comparisonView.addSubview($0)
        }
    }
    
    private func configureViewConstraints() {
        
        listRegularFormat.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        coinLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        
        priceLabel.snp.makeConstraints {
            $0.width.equalTo(80)
        }
        
        comparisonView.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.bottom.equalTo(listRegularFormat)
        }
        
        percentageComparison.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview()
        }
        
        absoluteComparison.snp.makeConstraints {
            $0.top.equalTo(percentageComparison.snp.bottom).offset(5)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(comparisonView).offset(-5)
        }
        
        amountLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
    }
    
    private func configureViewDetails() {
        contentView.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
    }
    
    func configureData(basedOn market : MarketPresentable) {
        coinLabel.text = market.coinName
        priceLabel.text = market.price
        
        percentageComparison.text = market.percentage
        absoluteComparison.text = market.absoluteDiff
        configureComparisonTextColor(basedOn: market.absoluteDiff)
        
        amountLabel.text = market.totalAmountPerDay
    }
    
    func configureComparisonTextColor(basedOn absDiff : String) {
        let selectedColor = DesignSystem.Color.InfoDeliver.positive.inUIColor()
        let unselectedColor = DesignSystem.Color.InfoDeliver.negative.inUIColor()
        
        if absDiff == "0" {
            return
        }
        
        if absDiff.starts(with: "-") {
            applyColorToComparisnLabel(with: unselectedColor)
        } else {
            applyColorToComparisnLabel(with: selectedColor)
        }
    }
    
    func applyColorToComparisnLabel(with color: UIColor) {
        percentageComparison.textColor = color
        absoluteComparison.textColor = color
    }
}
