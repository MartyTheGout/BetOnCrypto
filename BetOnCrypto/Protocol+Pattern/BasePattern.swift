//
//  BasePattern.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/6/25.
//

import UIKit

protocol ViewEssential3 {
    func configureViewHierarchy()
    func configureViewConstraints()
    func configureViewDetails()
}

class BaseView: UIView, ViewEssential3 {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewHierarchy()
        configureViewConstraints()
        configureViewDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(#function, "de-allocated from memory")
    }
    
    func configureViewHierarchy() {}
    func configureViewConstraints() {}
    func configureViewDetails() {}
}

class BaseViewController: UIViewController, ViewEssential3 {
    deinit {
        print(#function, "de-allocated from memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewHierarchy()
        configureViewConstraints()
        configureViewDetails()
    }
    
    func configureViewHierarchy() {}
    func configureViewConstraints() {}
    func configureViewDetails() {}
}
