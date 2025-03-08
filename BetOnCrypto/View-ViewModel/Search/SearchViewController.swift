//
//  SearchViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit

final class SearchViewController : BaseViewController {
    
    let mainView = SearchView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationTitleView()
    }
    
    private func configureNavigationTitleView() {
        let title = UILabel()
        title.text = "가상자산 / 심볼검색"
        title.font = .boldSystemFont(ofSize: 17)

        let spacer = UIView()
        let divider = Divider()
        
        let stack = UIStackView(arrangedSubviews: [title, spacer])
        stack.axis = .horizontal

        stack.snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(500).priority(.low)
        }
        
        navigationItem.titleView = stack
        
        navigationController?.navigationBar.addSubview(divider)
        divider.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-1)
        }
    }

    
    override func configureViewDetails() {
        view.backgroundColor = .white
    }
}
