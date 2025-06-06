//
//  SortingButton.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit

class SortingButton : UIButton {
    
    let unselectedColor = DesignSystem.Color.Tint.submain.inUIColor()
    let selectedColor = DesignSystem.Color.Background.main.inUIColor()
    
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
        label.textColor = DesignSystem.Color.Background.main.inUIColor()
        return label
    }()
    
    let imageContainer = UIView()
    
    let imageStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 0
        return stack
    }()
    
    lazy var upsideImage = {
        let imageView = UIImageView()
        imageView.image = DesignSystem.Icon.Input.ascendent.fill()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = unselectedColor
        return imageView
    }()
    
    lazy var downsideImage = {
        let imageView = UIImageView()
        imageView.image = DesignSystem.Icon.Input.descendent.fill() 
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = unselectedColor
        return imageView
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        
        label.text = title
        configureViewHierarchy()
        configureViewConstraints()
        
        //isUserInteractionEnabled = false is required no to have subView's intercept the tap event
        containerStack.isUserInteractionEnabled = false
        imageContainer.isUserInteractionEnabled = false
        imageStack.isUserInteractionEnabled = false
        label.isUserInteractionEnabled = false
        upsideImage.isUserInteractionEnabled = false
        downsideImage.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViewHierarchy() {
        imageStack.addArrangedSubview(upsideImage)
        imageStack.addArrangedSubview(downsideImage)
        
        imageContainer.addSubview(imageStack)
        
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
            $0.width.equalTo(5)
        }
        
        upsideImage.snp.makeConstraints {
            $0.width.equalTo(7)
            $0.height.equalTo(7.5)
        }
        
        downsideImage.snp.makeConstraints {
            $0.width.equalTo(7)
            $0.height.equalTo(7.5)
        }
        
        imageStack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(15)
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
        upsideImage.tintColor = upside
        downsideImage.tintColor = downside
    }
}
