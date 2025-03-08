//
//  ExchangeTickerRepository.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire


enum ChangeInfo : String {
    case rise = "RISE"
    case fall = "FALL"
    case even = "EVEN"
}

struct MarketPresentable {
    var coinName: String
    var price: String
    var percentage: String
    var absoluteDiff : String
    var totalAmountPerDay: String
    var changeInfo: ChangeInfo
}

final class MarketDataRepository {
    func getTickerData(dataFeeder : @escaping (_ with: [MarketData]) -> Void) {
        NetworkManager.shared.callRequest(ExchangeRouter.ticker) { (result: Result<[MarketData], AFError>) in
            switch result {
            case .success(let marketData) : dataFeeder(marketData)
            case .failure(let error): print(error)
            }
        }
    }
    
    func getTickerMock(dataFeeder: @escaping (_ with: [MarketPresentable]) -> Void) {
        
        let convertedData = mockMarketData.map {
            convertOriginToPresentable(with: $0)
        }
        
        dataFeeder(convertedData)
    }
}

extension MarketDataRepository {
    
    func covertCoinNameWithSlash(with coin: String) -> String {
        print(#function)
        let splitted = coin.split(separator: "-")
        
        print(splitted)
        guard splitted.count > 1 else {
            return coin
        }
        
        return "\(splitted[1])/\(splitted[0])"
    }
    
    func convertOriginToPresentable(with originalData: MarketData) -> MarketPresentable {
        return MarketPresentable(
            coinName: covertCoinNameWithSlash(with: originalData.market),
            price: NumberFormatManager.shared.getDecialWithMax2FD(originalValue: originalData.tradePrice),
            percentage: NumberFormatManager.shared.getPercentage(originalValue: originalData.changeRate),
            absoluteDiff: NumberFormatManager.shared.getDecialWithMax2FD(originalValue: originalData.changePrice),
            totalAmountPerDay: NumberFormatManager.shared.getValueBasedOnMilion(originalValue: originalData.accTradePrice24h),
            changeInfo: ChangeInfo(rawValue: originalData.change) ?? .even
        )
    }
}
