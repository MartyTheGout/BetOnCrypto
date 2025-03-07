//
//  Divider.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//



import UIKit
import SnapKit

class Divider : BaseView {
    let line = UIView()
    
    override func configureViewHierarchy() {
        addSubview(line)
    }
    
    override func configureViewConstraints() {
        line.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    override func configureViewDetails() {
        line.layer.borderColor = DesignSystem.Color.Background.segment.inUIColor().cgColor
        line.layer.borderWidth = 1
    }
}
