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
        setDecimalWithoutFDStyle()
        
        let millionConversion = originalValue / baseUnit
        
        if millionConversion < 1 {
            return numberFormatter.string(for: originalValue)!
        }
        
        return numberFormatter.string(for: millionConversion)! + "백만"
    }
    
    func getCurrentPriceStyle(originalValue : Double) -> String {
        let baseUnit = 1000.0
        
        let thousandConversion = originalValue / baseUnit
        
        if thousandConversion < 1 {
            setDecimalWithMax1FDStyle()
            return numberFormatter.string(for: originalValue)!
        }
        
        setDecimalWithoutFDStyle()
        return numberFormatter.string(for: originalValue)!
    }
    
    func setDefaultRoudingMode() {
        numberFormatter.roundingMode = .halfUp
    }
    
    func setDecimalStyle() {
        setDefaultRoudingMode()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
    }
    
    func setDecimalWithMax1FDStyle() {
        setDefaultRoudingMode()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 1
    }
    
    func setDecimalWithoutFDStyle() {
        setDefaultRoudingMode()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
    }
    
    func setPercentageStyle() {
        setDefaultRoudingMode()
        numberFormatter.numberStyle = .percent
        numberFormatter.maximumFractionDigits = 2
    }
}
