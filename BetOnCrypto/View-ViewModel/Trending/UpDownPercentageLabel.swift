//
//  UpDownPercentageLabel.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit

final class UpDownPercentageLabel: UILabel {
    
    func applyPercentageData(with data: String) {
        let color = data.starts(with: "-") ?
        DesignSystem.Color.InfoDeliver.negative.inUIColor() :
        DesignSystem.Color.InfoDeliver.positive.inUIColor()
        
        let symbol = data.starts(with: "-") ?
        DesignSystem.Icon.Input.descendent.fill() :
        DesignSystem.Icon.Input.ascendent.fill()
        
        let mutableAttributedString = NSMutableAttributedString(string: "")
        
        let attributedString = NSAttributedString(string: data , attributes: [
            .foregroundColor : color,
            .font : UIFont.boldSystemFont(ofSize: 9)
        ])
        
        let updownSymbolAttachment = NSTextAttachment()
        updownSymbolAttachment.image = symbol.withTintColor(color)
        updownSymbolAttachment.bounds = CGRect(x: 0, y: 0, width: 7, height: 7)
        
        let updownSymbol = NSMutableAttributedString(attachment: updownSymbolAttachment)
        updownSymbol.addAttributes([
            .font : UIFont.systemFont(ofSize: 9)
        ], range: NSRange(location: 0, length: updownSymbol.length))
        
        mutableAttributedString.append(updownSymbol)
        mutableAttributedString.append(attributedString)
        
        self.attributedText = mutableAttributedString
    }
}
