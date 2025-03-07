//
//  CryptoExchangeViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/6/25.
//

import UIKit
import SnapKit

final class MarketViewController : BaseViewController {
    
    let aView = UIView()
    let bView = UIView()
    let cView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, String(describing: self))
    }
    
    override func configureViewHierarchy() {
        [aView, bView, cView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        aView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        
        bView.snp.makeConstraints{
            $0.top.equalTo(aView.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        
        cView.snp.makeConstraints{
            $0.top.equalTo(bView.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
    }
    
    override func configureViewDetails() {
        view.backgroundColor = .white
        
        aView.backgroundColor = DesignSystem.Color.Tint.main.inUIColor()
        bView.backgroundColor = DesignSystem.Color.Tint.submain.inUIColor()
        cView.backgroundColor = DesignSystem.Color.Background.segment.inUIColor()
    }
}
