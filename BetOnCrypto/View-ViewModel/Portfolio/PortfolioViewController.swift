//
//  PortfolioViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit

final class PortfolioViewController : BaseViewController {
    
    private let mainView = InPreparingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureViewDetails() {
        view.backgroundColor = .white
    }
}

