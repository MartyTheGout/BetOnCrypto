//
//  NumberFormatManager.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/8/25.
//

import Foundation

class NumberFormatManager {
    static var shared = NumberFormatManager()
    private init() {}
    
    let numberFormatter = NumberFormatter()
    
    func getDecialWithMax2FD(originalValue: Double) -> String {
        setDecimalStyle()
        return numberFormatter.string(for: originalValue)!
    }
    
    func getPercentage(originalValue: Double) -> String {
        setPercentageStyle()
        return numberFormatter.string(for: originalValue)!
    }
    
    func getValueBasedOnMilion(originalValue: Double) -> String {
        let baseUnit = 1000000.0 // million
        setMillionStyle()
        
        let millionConversion = originalValue / baseUnit
        
        if millionConversion < 1 {
            return numberFormatter.string(for: originalValue)!
        }
        
        return numberFormatter.string(for: millionConversion)! + "백만"
    }
    
    func setDecimalStyle() {
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
    }
    
    func setPercentageStyle() {
        numberFormatter.numberStyle = .percent
    }
    
    func setMillionStyle() {
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
    }
}
