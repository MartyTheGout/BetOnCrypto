//
//  DetailViewControler.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: BaseViewController {
    
    private var keyword : String
    
    private let viewModel = DetailViewModel()
    
    private let disposeBag = DisposeBag()
    
    private let mainView = DetailView()
    
    init(keyword: String) {
        self.keyword = keyword
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        let input = DetailViewModel.Input(coinId: keyword)
        let output = viewModel.transform(input)
        
        output.detailDataSeq.drive(with: self) { owner, coinDetail in
            if let coinDetail {
                owner.mainView.applyData(with: coinDetail)
            }
        }.disposed(by: disposeBag)
    }
}
