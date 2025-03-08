//
//  ExchangeTickerRepository.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire



final class MarketDataRepository {
    func getTickerData(dataFeeder : @escaping (_ with: [MarketPresentable]) -> Void) {
        NetworkManager.shared.callRequest(ExchangeRouter.ticker) { [weak self] (result: Result<[MarketData], AFError>) in
            switch result {
            case .success(let marketData) :
                let convertedData: [MarketPresentable] = marketData.map {
                    self?.convertOriginToPresentable(with: $0) ?? MarketPresentable.mock
                }
                dataFeeder(convertedData)
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
        let splitted = coin.split(separator: "-")

        guard splitted.count > 1 else {
            return coin
        }
        
        return "\(splitted[1])/\(splitted[0])"
    }
    
    func convertOriginToPresentable(with originalData: MarketData) -> MarketPresentable {
        return MarketPresentable(
            originalCoin : originalData.market,
            presentableCoin: covertCoinNameWithSlash(with: originalData.market),
            originalPrice : originalData.tradePrice,
            presentablePrice: NumberFormatManager.shared.getDecialWithMax2FD(originalValue: originalData.tradePrice),
            originalPercentage: originalData.signedChangeRate,
            presentablePercentage: NumberFormatManager.shared.getPercentage(originalValue: originalData.signedChangeRate),
            originalDiff : originalData.signedChangePrice,
            presentableDiff : NumberFormatManager.shared.getDecialWithMax2FD(originalValue: originalData.signedChangePrice),
            originalTotalAmount: originalData.accTradePrice24h,
            presentableTotalAmount: NumberFormatManager.shared.getValueBasedOnMilion(originalValue: originalData.accTradePrice24h)
        )
    }
}
