//
//  SpinnerViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit
import SnapKit

class SpinnerViewController : BaseViewController {
    private var spinner = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = DesignSystem.Color.Tint.main.inUIColor()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
    }
    
    override func configureViewHierarchy() {
        view.addSubview(spinner)
    }
    
    override func configureViewConstraints() {
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
