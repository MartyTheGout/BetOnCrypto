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
import Toast

final class NoInternetViewController : BaseViewController {
    private let errorStream : BehaviorSubject<Bool>
    
    init(errorStream: BehaviorSubject<Bool>) {
        self.errorStream = errorStream
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainView = NoInternetView()
    private var childVC: UIViewController?
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        mainView.retryButton.rx.tap.bind(with: self){ owner,  _ in
            owner.createSpinnerView()
            
            owner.errorStream.take(1).bind { value in
                if value == false {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        owner.deleteSpinnerView()
                        owner.showNoInternetToastMessage()
                    }
                }
            }.disposed(by: owner.disposeBag)
        }
        .disposed(by: disposeBag)
    }
}

//MARK: - Activity Indicator
extension NoInternetViewController {
    private func createSpinnerView() {
        let child = SpinnerViewController()

         addChild(child)
         child.view.frame = view.frame
         view.addSubview(child.view)
         child.didMove(toParent: self)
        
        self.childVC = child

    }
    
    private func deleteSpinnerView() {
        guard let childVC else {
            print("[NoInternetViewController] There is no childVC here")
            return
        }
        
        childVC.willMove(toParent: nil)
        childVC.view.removeFromSuperview()
        childVC.removeFromParent()
    }
}

//MARK: - Toast Message
extension NoInternetViewController {
    private func showNoInternetToastMessage() {
        mainView.makeToast("네트워크 통신이 원활하지 않습니다.")
    }
}
