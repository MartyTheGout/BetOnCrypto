//
//  NFTCollectionViewCell.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/8/25.
//

import UIKit
import SnapKit
import Kingfisher

final class NFTCollectionViewCell : UICollectionViewCell {
    
    static var id : String {
        String(describing: self)
    }
    
    private let nftImage = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nftName = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 9)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
        label.textAlignment = .center
        return label
    }()
    
    private let nftPrice = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9)
        label.textColor = DesignSystem.Color.Tint.submain.inUIColor()
        return label
    }()
    
    private let priceChangeLabel = UpDownPercentageLabel()
    
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
        [nftImage, nftName, nftPrice, priceChangeLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func configureViewConstraints() {
        nftImage.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.centerX.equalTo(contentView)
            $0.size.equalTo(72)
        }
        
        nftName.snp.makeConstraints {
            $0.top.equalTo(nftImage.snp.bottom).offset(8)
            $0.centerX.equalTo(contentView)
            $0.width.equalTo(contentView).inset(4)
        }
        
        nftPrice.snp.makeConstraints {
            $0.top.equalTo(nftName.snp.bottom).offset(2)
            $0.centerX.equalTo(contentView)
        }
        
        priceChangeLabel.snp.makeConstraints {
            $0.top.equalTo(nftPrice.snp.bottom).offset(2)
            $0.centerX.equalTo(contentView)
        }
    }
    
    private func configureViewDetails() {
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        nftImage.layer.cornerRadius = 10
        nftImage.layer.masksToBounds = true
    }
}

extension NFTCollectionViewCell {
    func applyData(with item: TrendingNFTPresentable) {
        nftImage.kf.setImage(with: URL(string: item.thumb)!)
        
        nftName.text = item.name
        
        nftPrice.text = item.data.floorPrice
        
        priceChangeLabel.applyPercentageData(with: item.floorPrice24hPercentageChange)
    }
}
