//
//  ExchangeTickerRepository.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import RealmSwift
import Alamofire

final class SearchDataRepository {
    
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
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("[Error] delete LikedCoin record in Repository Failed")
        }
    }
    
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
}
