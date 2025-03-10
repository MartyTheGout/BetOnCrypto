//
//  UpDownPercentageLabel.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import UIKit

final class UpDownPercentageLabel: UILabel {
    
    func applyPercentageData(with data: String, bigSize: Bool = false) {
        let color = data.starts(with: "-") ?
        DesignSystem.Color.InfoDeliver.negative.inUIColor() :
        DesignSystem.Color.InfoDeliver.positive.inUIColor()
        
        let symbol = data.starts(with: "-") ?
        DesignSystem.Icon.Input.descendent.fill() :
        DesignSystem.Icon.Input.ascendent.fill()
        
        let fontSize = bigSize ? 15.0 : 9.0
        let symbolSize = bigSize ? 13.0 : 7.0
        
        let mutableAttributedString = NSMutableAttributedString(string: "")
        
        let attributedString = NSAttributedString(string: data , attributes: [
            .foregroundColor : color,
            .font : UIFont.boldSystemFont(ofSize: fontSize)
        ])
        
        let updownSymbolAttachment = NSTextAttachment()
        updownSymbolAttachment.image = symbol.withTintColor(color)
        updownSymbolAttachment.bounds = CGRect(x: 0, y: 0, width: symbolSize, height: symbolSize)
        
        let updownSymbol = NSMutableAttributedString(attachment: updownSymbolAttachment)
        
        mutableAttributedString.append(updownSymbol)
        mutableAttributedString.append(attributedString)
        
        self.attributedText = mutableAttributedString
    }
}
