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
        label.font = .boldSystemFont(ofSize: 15)
        label.text = "안내"
        return label
    }()
    
    let messageLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "네트워크 연결이 일시적으로 원활하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요."
        return label
    }()
    
    let divider = Divider()
    
    let retryButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = .init(top: 20, leading: 0, bottom: 20, trailing: 0)
        button.configuration = configuration
        
        let attributedText = NSAttributedString(string: "다시 시도하기", attributes: [
            .font : UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor : DesignSystem.Color.Tint.main.inUIColor()
        ])
        button.setAttributedTitle(attributedText, for: .normal)
        
        button.setTitleColor(DesignSystem.Color.Tint.main.inUIColor(), for: .normal)
        button.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        return button
    }()
    
    override func configureViewHierarchy() {
        [messageContainerView, titleLabel, messageLabel, divider, retryButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        messageContainerView.snp.makeConstraints {
            $0.center.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(messageContainerView).offset(30)
            $0.centerX.equalTo(messageContainerView)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(messageContainerView).inset(40)
        }
        
        divider.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(messageContainerView)
        }
        
        retryButton.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom).offset(2)
            $0.horizontalEdges.equalTo(messageContainerView)
            $0.bottom.equalTo(messageContainerView)
        }
    }
    
    override func configureViewDetails() {
        messageContainerView.backgroundColor = DesignSystem.Color.Background.main.inUIColor()
        backgroundColor = .black.withAlphaComponent(0.5)
    }
}
