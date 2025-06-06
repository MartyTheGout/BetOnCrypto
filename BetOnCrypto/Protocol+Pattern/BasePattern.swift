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
    
    /*
     This is for helping to track memory-leak-issue.
     TODO: Be sure to comment-out, when the app is not under developing / testing
     */
    deinit {
        print(String(describing: self),"View: de-allocated from memory")
    }
    
    func configureViewHierarchy() {}
    func configureViewConstraints() {}
    func configureViewDetails() {}
}

class BaseViewController: UIViewController, ViewEssential3 {
    
    /*
     This is for helping to track memory-leak-issue.
     TODO: Be sure to comment-out, when the app is not under developing / testing
     */
    deinit {
        print(String(describing: self),"ViewController: de-allocated from memory")
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
