//
//  NoInternetViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/6/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class NoInternetViewController : BaseViewController {
    private let mainView = NoInternetView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        mainView.retryButton.rx.tap.bind { _ in
            print("make network try again")
        }
        .disposed(by: disposeBag)
    }
}

