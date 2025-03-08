//
//  CollectionRegularForm.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit
/**
 
 This, "CollectionRegularForm"  provide  regular-consistent spacing in header, also in collection column record.
 */
final class CollectionListRegularForm : UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        distribution = .equalSpacing
        spacing = 0
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
