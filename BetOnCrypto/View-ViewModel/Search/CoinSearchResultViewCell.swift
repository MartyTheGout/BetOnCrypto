//
//  CoinSearchResultViewCell.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit
import SnapKit
import Kingfisher

final class CoinSearchResultViewCell: UICollectionViewCell {
    
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
    
    //TODO: This seems to be required
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private let imageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let symbolLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
        label.textAlignment = .right
        return label
    }()
    
    private let rankingContainerView = {
       let view = UIView()
        view.backgroundColor = DesignSystem.Color.Background.segment.inUIColor()
        return view
    }()
    
    private let rankingLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 9)
        label.textColor = DesignSystem.Color.Tint.submain.inUIColor()
        label.textAlignment = .right
        return label
    }()
    
    private let nameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = DesignSystem.Color.Tint.submain.inUIColor()
        label.textAlignment = .right
        return label
    }()
    
    let likeButton = {
        let button = UIButton()
        button.setImage(DesignSystem.Icon.Input.star.toUIImage(), for: .normal)
        return button
    }()
    
    private func configureViewHierarchy() {
        [imageView, symbolLabel, rankingContainerView, nameLabel, likeButton ].forEach {
            contentView.addSubview($0)
        }
        
        rankingContainerView.addSubview(rankingLabel)
    }
    
    private func configureViewConstraints() {
        imageView.snp.makeConstraints {
            $0.size.equalTo(36)
            $0.top.bottom.leading.equalTo(contentView).offset(12)
            $0.bottom.equalTo(contentView).offset(-12)
        }
        
        symbolLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(12)
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
        }
        
        rankingContainerView.snp.makeConstraints {
            $0.bottom.equalTo(symbolLabel)
            $0.leading.equalTo(symbolLabel.snp.trailing).offset(8)
        }
        
        rankingLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(2)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(symbolLabel.snp.bottom).offset(4)
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
        }
        
        likeButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-8)
        }
    }
    
    private func configureViewDetails() {}
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.layer.masksToBounds = true
        
        rankingContainerView.layer.cornerRadius = 5
        rankingContainerView.layer.masksToBounds = true
    }
}

//MARK: - Data related
extension CoinSearchResultViewCell {
    func applyData(with data: SearchCoin) {
        imageView.kf.setImage(with: URL(string: data.thumb)!)
        
        symbolLabel.text = data.symbol
        nameLabel.text = data.name
        
        if let rankInfo = data.marketCapRank {
            rankingLabel.text = "#\(rankInfo)"
        }
    }
}
