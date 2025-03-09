//
//  CoinCollectionViewCell.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/8/25.
//

import UIKit
import SnapKit
import Kingfisher

class CoinCollectionViewCell: UICollectionViewCell {
    static var id : String {
        String(describing: self)
    }
    
    let numberLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
        return label
    }()
    
    let coinImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let coinSymbolLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
        return label
    }()
    
    let coinNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9)
        label.textColor = DesignSystem.Color.Tint.submain.inUIColor()
        return label
    }()
    
    let changePercentageLabel = {
        let label = UILabel()
        return label
    }()
    
    
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
        coinImageView.layer.cornerRadius = coinImageView.frame.height / 2
    }
}

extension CoinCollectionViewCell {
    
    func applyData(with data: SearchCoin, number: Int) {
        
        numberLabel.text = "\(number)"
        
        coinImageView.kf.setImage(with: URL(string: data.thumb))
        
        coinSymbolLabel.text = data.symbol
        coinNameLabel.text = data.name
        
        applyPercentageChange(data: "\(data.data.priceChangePercentage24h.krw)")
        
    }
    
    private func applyPercentageChange(data: String) {
        let mutableAttributedString = NSMutableAttributedString(string: "")
        mutableAttributedString.addAttributes(
            [
                .font : UIFont.boldSystemFont(ofSize: 9)
            ],
            range: NSRange(location: 0, length: mutableAttributedString.length)
        )
        
        let attributedString = NSAttributedString(string: data , attributes: [
            .foregroundColor : DesignSystem.Color.InfoDeliver.negative.inUIColor(),
            .font : UIFont.boldSystemFont(ofSize: 9)
        ])
        
        let updownSymbolAttachment = NSTextAttachment()
        updownSymbolAttachment.image = DesignSystem.Icon.Input.descendent.fill().withTintColor(DesignSystem.Color.InfoDeliver.negative.inUIColor())
        updownSymbolAttachment.bounds = CGRect(x: 0, y: 0, width: 7, height: 7)
        
        let updownSymbol = NSMutableAttributedString(attachment: updownSymbolAttachment)
        updownSymbol.addAttributes([
            .font : UIFont.systemFont(ofSize: 9)
        ], range: NSRange(location: 0, length: updownSymbol.length))
        
        mutableAttributedString.append(updownSymbol)
        mutableAttributedString.append(attributedString)
        
        changePercentageLabel.attributedText = mutableAttributedString
    }
}
