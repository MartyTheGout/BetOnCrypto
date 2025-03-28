//
//  CoinCollectionViewCell.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/8/25.
//

import UIKit
import SnapKit
import Kingfisher

final class CoinCollectionViewCell: UICollectionViewCell {
    static var id : String {
        String(describing: self)
    }
    
    private let numberLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
        return label
    }()
    
    private let coinImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let coinSymbolLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
        return label
    }()
    
    private let coinNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9)
        label.textColor = DesignSystem.Color.Tint.submain.inUIColor()
        return label
    }()
    
    private let changePercentageLabel = UpDownPercentageLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierarchy()
        configureViewConstraints()
        configureViewDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        [numberLabel, coinImageView, coinNameLabel, coinSymbolLabel, changePercentageLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configureViewConstraints() {
        numberLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(8)
        }
        
        coinImageView.snp.makeConstraints {
            $0.size.equalTo(26)
            $0.leading.equalTo(numberLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(contentView)
        }
        
        coinSymbolLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.leading.equalTo(coinImageView.snp.trailing).offset(8)
        }
        
        coinNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView).offset(-8)
            $0.leading.equalTo(coinImageView.snp.trailing).offset(8)
        }
        
        changePercentageLabel.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp.trailing).offset(-8)
            $0.centerY.equalTo(contentView)
        }
    }
    
    private func configureViewDetails() {}
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        coinImageView.layer.masksToBounds = true
        coinImageView.layer.cornerRadius = 10
    }
}

extension CoinCollectionViewCell {
    
    func applyData(with data: TrendingCoinPresentable, number: Int) {
        
        numberLabel.text = "\(number)"
        
        coinImageView.kf.setImage(with: URL(string: data.thumb))
        
        coinSymbolLabel.text = data.symbol
        coinNameLabel.text = data.name
        
        changePercentageLabel.applyPercentageData(with: data.data.krw)
    }
}
