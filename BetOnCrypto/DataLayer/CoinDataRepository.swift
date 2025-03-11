//
//  ExchangeTickerRepository.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import RealmSwift
import Alamofire

final class CoinDataRepository {
    
    private let realm = try! Realm()
    
    func printRepositorySandBox() {
        print(realm.configuration.fileURL!)
    }
    
    func getLikeRecords() -> Results<LikedCoin> {
        realm.objects(LikedCoin.self)
    }
    
    func addLikeRecords(of data: LikedCoin) {
        do {
            try realm.write {
                realm.add(data)
            }
        } catch {
            print("[Error] write LikedCoin record in Repository Failed")
        }
    }
    
    func deleteLikeRecords(of data: LikedCoin) {
        do {
            if let record = realm.object(ofType: LikedCoin.self, forPrimaryKey: data.id) {
                try realm.write {
                    realm.delete(record)
                }
            } else {
                print("[Error] Object not found in Realm")
            }
        } catch {
            print("[Error] delete LikedCoin record in Repository Failed")
        }
    }
    
    //MARK: - Search
    func getCoinWithKeyword(
        keyword: String,
        dataFeeder : @escaping ([SearchCoin]) -> Void
    ) {
        NetworkManager.shared.callRequest(CoinAndNFTRouter.search(query: keyword)) {(result: Result<SearchResult, AFError>) in
            switch result {
            case .success(let searchResult) :
                dataFeeder(searchResult.coins)
            case .failure(let error): print(error)
            }
        }
    }
    
    func getTrendingMock(dataFeeder: @escaping ([SearchCoin]) -> Void) {
        dataFeeder(mockSearchCoin)
    }
    
    //MARK: - Detail
    func getCoinDetail(id: String, dataFeeder : @escaping (CoinDetailPresentable) -> Void ) {
        NetworkManager.shared.callRequest(CoinAndNFTRouter.detail(id: id)) {[weak self] (result: Result<[CoinDetail], AFError>) in
            switch result {
            case .success(let detailResult) :
                guard let detailResult = detailResult.first else {
                    print("[CoinDetail Response] There is no such coin detail")
                    return
                }
                
                if let converted = self?.convertOriginalDetailToPresentable(original: detailResult) {
                    dataFeeder(converted)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getDetailMock(dataFeeder : @escaping (CoinDetailPresentable) -> Void ) {
        let converted = convertOriginalDetailToPresentable(original: mockCoinDetail)
        
        dataFeeder(converted)
    }
}

extension CoinDataRepository {
    private func convertOriginalDetailToPresentable(original: CoinDetail) -> CoinDetailPresentable {
        return CoinDetailPresentable(
            id: original.id,
            symbol: original.symbol,
            name: original.name,
            image: original.image,
            currentPrice: convertDoubleToKRWString(original.currentPrice),
            priceChangePercentage24h: convertPercentageInFormat(original.priceChangePercentage24h!/100) ,
            marketCap: convertDoubleToKRWString(original.marketCap),
            fullyDilutedValuation: convertDoubleToKRWString(original.fullyDilutedValuation ?? 0.0),
            totalVolume: convertDoubleToKRWString(original.totalVolume),
            high24h: convertDoubleToKRWString(original.high24h ?? 0.0),
            low24h: convertDoubleToKRWString(original.low24h ?? 0.0),
            ath: convertDoubleToKRWString(original.ath),
            athDate: convertToNormalDateFormat(original.athDate),
            atl: convertDoubleToKRWString(original.atl),
            atlDate: convertToNormalDateFormat(original.atlDate),
            lastUpdated: convertToUpdatedFormat(original.lastUpdated),
            sparklineIn7d: original.sparklineIn7d?.price
        )
    }
    
    private func convertDoubleToKRWString(_ value: Double) -> String {
        "₩" + NumberFormatManager.shared.getDecialWithMax2FD(originalValue: value)
    }
    
    private func convertPercentageInFormat (_ value : Double) -> String {
        NumberFormatManager.shared.getPercentage(originalValue: value)
    }
    
    private func convertToUpdatedFormat(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "M/dd hh:mm:ss 업데이트"
        return dateFormatter.string(from: date ?? Date())
    }
    
    private func convertToNormalDateFormat(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "yy년 M월 dd일"
        return dateFormatter.string(from: date ?? Date())
    }
}
