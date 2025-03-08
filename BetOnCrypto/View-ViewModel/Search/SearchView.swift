//
//  SearchView.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/8/25.
//

import UIKit

class SearchView: BaseView {
    
    let searchField = CustomSearchField()
    
    override func configureViewHierarchy() {
        [searchField].forEach {
            addSubview($0)
        }
    }
    
    override func configureViewConstraints() {
        searchField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(24)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
    
    override func configureViewDetails() {
        
    }
    
    
    
}
