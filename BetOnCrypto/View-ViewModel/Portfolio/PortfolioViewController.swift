//
//  PortfolioViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit

final class PortfolioViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, String(describing: self))
    }
    
    override func configureViewDetails() {
        view.backgroundColor = .white
    }
}

