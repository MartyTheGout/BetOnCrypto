//
//  SortingButton.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit

class SortingButton : UIButton {
    
    let unselectedColor = DesignSystem.Color.Tint.submain.inUIColor()
    let selectedColor = DesignSystem.Color.Tint.main.inUIColor()
    
    let containerStack = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        return stack
    }()
    
    let label = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .black)
        label.textAlignment = .right
        return label
    }()
    
    let imageContainer = UIView()
    
    let imageStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()
    
    lazy var upsideImage = {
        let imageView = UIImageView()
        imageView.image = DesignSystem.Icon.Input.ascendent.toUIImage().withTintColor(unselectedColor)
        return imageView
    }()
    
    lazy var downsideImage = {
        let imageView = UIImageView()
        imageView.image = DesignSystem.Icon.Input.descendent.toUIImage().withTintColor(unselectedColor)
        return imageView
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        
        label.text = title
        configureViewHierarchy()
        configureViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        imageStack.addArrangedSubview(upsideImage)
        imageStack.addArrangedSubview(downsideImage)
        
        
        imageContainer.addSubview(imageStack)
//        imageContainer.addSubview(upsideImage)
//        imageContainer.addSubview(downsideImage)
        
        containerStack.addArrangedSubview(label)
        containerStack.addArrangedSubview(imageContainer)
        
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageContainer.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        addSubview(containerStack)
    }
    
    private func configureViewConstraints() {
        containerStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageContainer.snp.makeConstraints {
            $0.width.equalTo(15)
        }
        
        upsideImage.snp.makeConstraints {
            $0.size.equalTo(10)
        }
        
        downsideImage.snp.makeConstraints {
            $0.size.equalTo(10)
        }
        
        imageStack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func reflectSortingData(option: SortingSubOption) {
        switch option {
        case .none:
            changeTintColorOnImage(upside: unselectedColor, downside: unselectedColor)
        case .ascendent:
            changeTintColorOnImage(upside: selectedColor, downside: unselectedColor)
        case .descendent:
            changeTintColorOnImage(upside: unselectedColor, downside: selectedColor)
        }
    }
    
    func changeTintColorOnImage(upside: UIColor, downside: UIColor) {
        upsideImage.image?.withTintColor(upside)
        downsideImage.image?.withTintColor(downside)
    }
}
