//
//  CoinSearchResultView.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit

final class InPreparingView: BaseView {
    
    private let label = {
        let label = UILabel()
        label.text = "준비 중\n입니다"
        label.font = .systemFont(ofSize: 20)
        label.textColor = DesignSystem.Color.Tint.main.inUIColor()
        label.textAlignment = .center
        return label
    }()
    
    override func configureViewHierarchy() {
        addSubview(label)
    }
    
    override func configureViewConstraints() {
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
