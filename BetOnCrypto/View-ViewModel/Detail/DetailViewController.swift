//
//  DetailViewControler.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit

class DetailViewController: BaseViewController {
    
    var keyword : String
    
    init(keyword: String) {
        self.keyword = keyword
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, "didload")
        print(self, keyword)
    }
}
