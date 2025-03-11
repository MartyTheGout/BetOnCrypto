//
//  ExchangeTickerRepository.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire

final class TrendingDataRepository {
    func getTrendingData(
        dataFeeder : @escaping ([TrendingCoinPresentable], [TrendingNFTPresentable]) -> Void,
        errorMessageFeeder: @escaping (String) -> Void
    ) {
        NetworkManager.shared.callRequest(CoinAndNFTRouter.trending) { [weak self] (result: Result<TrendingResponse, AFError>, statusCode: Int?) in
            switch result {
            case .success(let trendingData) :
                let convertedCoin = self?.convertOriginToPresentableCoin(originalData: trendingData.coins)
                let convertedNFT = self?.convertOriginToPresentableNFT(originalData: trendingData.nfts)
                
                guard let convertedCoin, let convertedNFT else { return }
                dataFeeder(convertedCoin, convertedNFT)
            case .failure(let error):
                print(error)
                let definedErrorMessage = NetworkManager.shared.getErrorMessage(statusCode: statusCode)
                errorMessageFeeder(definedErrorMessage)
            }
        }
    }
    
    func getTrendingMock(dataFeeder: @escaping ([TrendingCoinPresentable], [TrendingNFTPresentable]) -> Void) {
        let convertedCoin = convertOriginToPresentableCoin(originalData: mockedTrendingResponse.coins)
        let convertedNFT = convertOriginToPresentableNFT(originalData: mockedTrendingResponse.nfts)
        
        dataFeeder(convertedCoin, convertedNFT)
    }
}

extension TrendingDataRepository {
    private func convertOriginToPresentableCoin(originalData: [TrendingCoinItem]) -> [TrendingCoinPresentable] {
        let converted = originalData.map {
            let coinDetail = $0.item

            let percetageKRW = coinDetail.data.priceChangePercentage24h["krw"]!
            
            return TrendingCoinPresentable(
                id: coinDetail.id,
                name: coinDetail.name,
                symbol: coinDetail.symbol,
                thumb: coinDetail.thumb,
                data: TrendingCoinDataPresentable(krw: NumberFormatManager.shared.getDecialWithMax2FD(originalValue: percetageKRW) + "%")
            )
        }
        
        return converted
    }
    
    private func convertOriginToPresentableNFT(originalData: [TrendingNFTItem]) -> [TrendingNFTPresentable] {
        let converted = originalData.map {
            
            return TrendingNFTPresentable(
                name: $0.name,
                thumb: $0.thumb,
                floorPrice24hPercentageChange: NumberFormatManager.shared.getDecialWithMax2FD(originalValue: $0.floorPrice24hPercentageChange),
                data: TrendingNFTDataPresentable(floorPrice: $0.data.floorPrice))
        }
        
        return converted
    }
}
