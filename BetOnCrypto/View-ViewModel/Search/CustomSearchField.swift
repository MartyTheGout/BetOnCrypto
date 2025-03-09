//
//  CustomSearchField.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/8/25.
//

import UIKit

final class CustomSearchField : BaseView {
    
    private let containerView = UIView()
    
    let textField = {
        let textField = UITextField()
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "검색어를 입력해주세요.",
            attributes: [
            .foregroundColor : DesignSystem.Color.Tint.submain.inUIColor(),
            .font: UIFont.systemFont(ofSize: 15)
        ])
        return textField
    }()
    
    private let searchImage = {
        let imageView = UIImageView()
        imageView.image = DesignSystem.Icon.Input.search.toUIImage()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func configureViewHierarchy() {
        addSubview(containerView)
        
        [textField, searchImage].forEach {
            containerView.addSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchImage.snp.makeConstraints {
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.size.equalTo(26)
            $0.centerY.equalTo(containerView)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalTo(searchImage.snp.trailing).offset(8)
            $0.top.equalTo(containerView).offset(12)
            $0.trailing.equalTo(containerView).offset(-16)
            $0.bottom.equalTo(containerView).offset(-12)
        }
    }
    
    override func configureViewDetails() {
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = DesignSystem.Color.Tint.submain.inUIColor().cgColor
        
        searchImage.tintColor = DesignSystem.Color.Tint.submain.inUIColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = containerView.frame.height / 2
        
    }
}
