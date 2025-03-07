//
//  CryptoExchangeViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/6/25.
//

import UIKit

class CryptoExchangeViewController : BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, String(describing: self))
    }
    
    override func configureViewDetails() {
        view.backgroundColor = .white
    }
}
