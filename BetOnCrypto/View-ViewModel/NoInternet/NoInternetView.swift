//
//  NoInternetView.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/6/25.
//

import UIKit
import SnapKit

final class NoInternetView: BaseView {
    
    final let messageContainerView = UIView()
    
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "안내"
        return label
    }()
    
    let messageLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.text = "네트워크 연결이 일시적으로 원활하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요."
        return label
    }()
    
    let retryButton = {
        let button = UIButton()
        button.setTitle("다시 시도하기", for: .normal)
        button.setTitleColor(DesignSystem.Color.Tint.main.inUIColor(), for: .normal)
        button.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        return button
    }()
    
    override func configureViewHierarchy() {
        [messageContainerView, titleLabel, messageLabel, retryButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        messageContainerView.snp.makeConstraints {
            $0.center.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(messageContainerView).offset(8)
            $0.centerX.equalTo(messageContainerView)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(messageContainerView).inset(40)
        }
        
        retryButton.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(messageContainerView)
            $0.bottom.equalTo(messageContainerView)
        }
    }
    
    override func configureViewDetails() {
        messageContainerView.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        backgroundColor = .black.withAlphaComponent(0.5)
    }
}
