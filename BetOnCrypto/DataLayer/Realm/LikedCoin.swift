//
//  LikedCoin.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/9/25.
//

import Foundation
import RealmSwift

class LikedCoin: Object {
    @Persisted(primaryKey: true) var id : String // crypto currency's id
    
    convenience init(id: String) {
        self.init()
        self.id = id
    }
}
