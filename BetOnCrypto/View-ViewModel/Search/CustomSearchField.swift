//
//  CustomSearchField.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/8/25.
//

import UIKit

class CustomSearchField : BaseView {
    
    let containerView = UIView()
    
    let textField = {
        let textField = UITextField()
        
        textField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력해주세요.", attributes: [
            .foregroundColor : DesignSystem.Color.Tint.submain.inUIColor()
        ])
        return textField
    }()
    
    let searchImage = {
        let imageView = UIImageView()
        imageView.image = DesignSystem.Icon.Input.search.toUIImage()
        imageView.contentMode = .scaleToFill
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
            $0.leading.equalTo(searchImage.snp.trailing).offset(16)
            $0.top.equalTo(containerView).offset(16)
            $0.trailing.equalTo(containerView).offset(-16)
            $0.bottom.equalTo(containerView).offset(-16)
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
