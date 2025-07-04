//
//  Exchange.swift
//  SimpleWeather
//
//  Created by marty.academy on 3/7/25.
//

import Foundation

struct MarketData: Codable {
    let market: String
    let tradeDate: String?
    let tradeTime: String?
    let tradeDateKst: String?
    let tradeTimeKst: String?
    let tradeTimestamp: Int64?
    let openingPrice: Double?
    let highPrice: Double?
    let lowPrice: Double?
    let tradePrice: Double
    let prevClosingPrice: Double
    let change: String
    let changePrice: Double
    let changeRate: Double
    let signedChangePrice: Double
    let signedChangeRate: Double
    let tradeVolume: Double
    let accTradePrice: Double
    let accTradePrice24h: Double
    let accTradeVolume: Double
    let accTradeVolume24h: Double
    let highest52WeekPrice: Double
    let highest52WeekDate: String
    let lowest52WeekPrice: Double
    let lowest52WeekDate: String
    let timestamp: Int64
    
    init(
        market: String,
        tradeDate: String,
        tradeTime: String,
        tradeDateKst: String,
        tradeTimeKst: String,
        tradeTimestamp: Int64,
        openingPrice: Double,
        highPrice: Double,
        lowPrice: Double,
        tradePrice: Double,
        prevClosingPrice: Double,
        change: String,
        changePrice: Double,
        changeRate: Double,
        signedChangePrice: Double,
        signedChangeRate: Double,
        tradeVolume: Double,
        accTradePrice: Double,
        accTradePrice24h: Double,
        accTradeVolume: Double,
        accTradeVolume24h: Double,
        highest52WeekPrice: Double,
        highest52WeekDate: String,
        lowest52WeekPrice: Double,
        lowest52WeekDate: String,
        timestamp: Int64
    ) {
        self.market = market
        self.tradeDate = tradeDate
        self.tradeTime = tradeTime
        self.tradeDateKst = tradeDateKst
        self.tradeTimeKst = tradeTimeKst
        self.tradeTimestamp = tradeTimestamp
        self.openingPrice = openingPrice
        self.highPrice = highPrice
        self.lowPrice = lowPrice
        self.tradePrice = tradePrice
        self.prevClosingPrice = prevClosingPrice
        self.change = change
        self.changePrice = changePrice
        self.changeRate = changeRate
        self.signedChangePrice = signedChangePrice
        self.signedChangeRate = signedChangeRate
        self.tradeVolume = tradeVolume
        self.accTradePrice = accTradePrice
        self.accTradePrice24h = accTradePrice24h
        self.accTradeVolume = accTradeVolume
        self.accTradeVolume24h = accTradeVolume24h
        self.highest52WeekPrice = highest52WeekPrice
        self.highest52WeekDate = highest52WeekDate
        self.lowest52WeekPrice = lowest52WeekPrice
        self.lowest52WeekDate = lowest52WeekDate
        self.timestamp = timestamp
    }
    
    
    enum CodingKeys: String, CodingKey {
        case market
        case tradeDate = "trade_date"
        case tradeTime = "trade_time"
        case tradeDateKst = "trade_date_kst"
        case tradeTimeKst = "trade_time_kst"
        case tradeTimestamp = "trade_timestamp"
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case prevClosingPrice = "prev_closing_price"
        case change
        case changePrice = "change_price"
        case changeRate = "change_rate"
        case signedChangePrice = "signed_change_price"
        case signedChangeRate = "signed_change_rate"
        case tradeVolume = "trade_volume"
        case accTradePrice = "acc_trade_price"
        case accTradePrice24h = "acc_trade_price_24h"
        case accTradeVolume = "acc_trade_volume"
        case accTradeVolume24h = "acc_trade_volume_24h"
        case highest52WeekPrice = "highest_52_week_price"
        case highest52WeekDate = "highest_52_week_date"
        case lowest52WeekPrice = "lowest_52_week_price"
        case lowest52WeekDate = "lowest_52_week_date"
        case timestamp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        market = try container.decodeIfPresent(String.self, forKey: .market) ?? ""
        tradeDate = try container.decodeIfPresent(String.self, forKey: .tradeDate) ?? ""
        tradeTime = try container.decodeIfPresent(String.self, forKey: .tradeTime) ?? ""
        tradeDateKst = try container.decodeIfPresent(String.self, forKey: .tradeDateKst) ?? ""
        tradeTimeKst = try container.decodeIfPresent(String.self, forKey: .tradeTimeKst) ?? ""
        
        tradeTimestamp = try container.decodeIfPresent(Int64.self, forKey: .tradeTimestamp) ?? 0
        timestamp = try container.decodeIfPresent(Int64.self, forKey: .timestamp) ?? 0
        
        openingPrice = try container.decodeIfPresent(Double.self, forKey: .openingPrice) ?? 0.0
        highPrice = try container.decodeIfPresent(Double.self, forKey: .highPrice) ?? 0.0
        lowPrice = try container.decodeIfPresent(Double.self, forKey: .lowPrice) ?? 0.0
        tradePrice = try container.decodeIfPresent(Double.self, forKey: .tradePrice) ?? 0.0
        prevClosingPrice = try container.decodeIfPresent(Double.self, forKey: .prevClosingPrice) ?? 0.0
        
        change = try container.decodeIfPresent(String.self, forKey: .change) ?? "EVEN"
        
        changePrice = try container.decodeIfPresent(Double.self, forKey: .changePrice) ?? 0.0
        changeRate = try container.decodeIfPresent(Double.self, forKey: .changeRate) ?? 0.0
        signedChangePrice = try container.decodeIfPresent(Double.self, forKey: .signedChangePrice) ?? 0.0
        signedChangeRate = try container.decodeIfPresent(Double.self, forKey: .signedChangeRate) ?? 0.0
        
        tradeVolume = try container.decodeIfPresent(Double.self, forKey: .tradeVolume) ?? 0.0
        accTradePrice = try container.decodeIfPresent(Double.self, forKey: .accTradePrice) ?? 0.0
        accTradePrice24h = try container.decodeIfPresent(Double.self, forKey: .accTradePrice24h) ?? 0.0
        accTradeVolume = try container.decodeIfPresent(Double.self, forKey: .accTradeVolume) ?? 0.0
        accTradeVolume24h = try container.decodeIfPresent(Double.self, forKey: .accTradeVolume24h) ?? 0.0
        
        highest52WeekPrice = try container.decodeIfPresent(Double.self, forKey: .highest52WeekPrice) ?? 0.0
        highest52WeekDate = try container.decodeIfPresent(String.self, forKey: .highest52WeekDate) ?? ""
        lowest52WeekPrice = try container.decodeIfPresent(Double.self, forKey: .lowest52WeekPrice) ?? 0.0
        lowest52WeekDate = try container.decodeIfPresent(String.self, forKey: .lowest52WeekDate) ?? ""
    }
}

let mockMarketData: [MarketData] = [
    MarketData(
        market: "KRW-VIRTUAL",
        tradeDate: "20250306",
        tradeTime: "053346",
        tradeDateKst: "20250306",
        tradeTimeKst: "143346",
        tradeTimestamp: 1741239226446,
        openingPrice: 134990000.00000000,
        highPrice: 137480000.00000000,
        lowPrice: 133874000.00000000,
        tradePrice: 137463000.00000000,
        prevClosingPrice: 134990000.00000000,
        change: "RISE",
        changePrice: 2473000.00000000,
        changeRate: 0.0183198755,
        signedChangePrice: 2473000.00000000,
        signedChangeRate: 0.0183198755,
        tradeVolume: 0.05127005,
        accTradePrice: 124094971987.43827,
        accTradePrice24h: 501017864821.89674,
        accTradeVolume: 912.48104503,
        accTradeVolume24h: 3726.96698455,
        highest52WeekPrice: 163325000.00000000,
        highest52WeekDate: "2025-01-20",
        lowest52WeekPrice: 72100000.00000000,
        lowest52WeekDate: "2024-08-05",
        timestamp: 1741239226475
    ),
    MarketData(
        market: "KRW-TOKAMAK",
        tradeDate: "20250306",
        tradeTime: "053345",
        tradeDateKst: "20250306",
        tradeTimeKst: "143345",
        tradeTimestamp: 1741239225515,
        openingPrice: 3340000.00000000,
        highPrice: 3445000.00000000,
        lowPrice: 3325000.00000000,
        tradePrice: 3441000.00000000,
        prevClosingPrice: 3340000.00000000,
        change: "RISE",
        changePrice: 101000.00000000,
        changeRate: 0.0302395210,
        signedChangePrice: 101000.00000000,
        signedChangeRate: 0.0302395210,
        tradeVolume: 0.14530659,
        accTradePrice: 45299449862.31482,
        accTradePrice24h: 162500235370.78899,
        accTradeVolume: 13390.26494099,
        accTradeVolume24h: 48692.35054182,
        highest52WeekPrice: 5900000.00000000,
        highest52WeekDate: "2024-12-16",
        lowest52WeekPrice: 2955000.00000000,
        lowest52WeekDate: "2024-09-06",
        timestamp: 1741239225556
    ),
    MarketData(
        market: "KRW-XRP",
        tradeDate: "20250306",
        tradeTime: "053347",
        tradeDateKst: "20250306",
        tradeTimeKst: "143347",
        tradeTimestamp: 1741239227594,
        openingPrice: 3723.00000000,
        highPrice: 3792.00000000,
        lowPrice: 3677.00000000,
        tradePrice: 3772.00000000,
        prevClosingPrice: 3723.00000000,
        change: "RISE",
        changePrice: 49.00000000,
        changeRate: 0.0131614290,
        signedChangePrice: 49.00000000,
        signedChangeRate: 0.0131614290,
        tradeVolume: 1261.02888888,
        accTradePrice: 198542910741.68432128,
        accTradePrice24h: 865892603464.66665811,
        accTradeVolume: 53103806.74003013,
        accTradeVolume24h: 232782437.24250982,
        highest52WeekPrice: 4984.00000000,
        highest52WeekDate: "2025-01-20",
        lowest52WeekPrice: 560.20000000,
        lowest52WeekDate: "2024-07-05",
        timestamp: 1741239227643
    ),
    MarketData(
        market: "KRW-SOL",
        tradeDate: "20250306",
        tradeTime: "053346",
        tradeDateKst: "20250306",
        tradeTimeKst: "143346",
        tradeTimestamp: 1741239226996,
        openingPrice: 217950.00000000,
        highPrice: 223800.00000000,
        lowPrice: 215000.00000000,
        tradePrice: 222650.00000000,
        prevClosingPrice: 217950.00000000,
        change: "RISE",
        changePrice: 4700.00000000,
        changeRate: 0.0215645790,
        signedChangePrice: 4700.00000000,
        signedChangeRate: 0.0215645790,
        tradeVolume: 3.59307318,
        accTradePrice: 42850387284.4030115,
        accTradePrice24h: 188606990578.9396275,
        accTradeVolume: 195042.33442546,
        accTradeVolume24h: 865326.37753844,
        highest52WeekPrice: 454500.00000000,
        highest52WeekDate: "2025-01-19",
        lowest52WeekPrice: 160500.00000000,
        lowest52WeekDate: "2024-08-05",
        timestamp: 1741239227034
    ),
    MarketData(
        market: "KRW-ADA",
        tradeDate: "20250306",
        tradeTime: "053347",
        tradeDateKst: "20250306",
        tradeTimeKst: "143347",
        tradeTimestamp: 1741239227278,
        openingPrice: 1450.00000000,
        highPrice: 1474.00000000,
        lowPrice: 1411.00000000,
        tradePrice: 1420.00000000,
        prevClosingPrice: 1450.00000000,
        change: "FALL",
        changePrice: 30.00000000,
        changeRate: 0.0206896552,
        signedChangePrice: -30.00000000,
        signedChangeRate: -0.0206896552,
        tradeVolume: 7070.86958459,
        accTradePrice: 123722616084.48639393,
        accTradePrice24h: 618707068562.00959798,
        accTradeVolume: 86200072.56710061,
        accTradeVolume24h: 425653746.24103055,
        highest52WeekPrice: 1942.00000000,
        highest52WeekDate: "2024-12-03",
        lowest52WeekPrice: 399.50000000,
        lowest52WeekDate: "2024-08-05",
        timestamp: 1741239227323
    ),
    MarketData(
        market: "KRW-BCH",
        tradeDate: "20250306",
        tradeTime: "053347",
        tradeDateKst: "20250306",
        tradeTimeKst: "143347",
        tradeTimestamp: 1741239227554,
        openingPrice: 584600.00000000,
        highPrice: 623900.00000000,
        lowPrice: 571300.00000000,
        tradePrice: 614100.00000000,
        prevClosingPrice: 584600.00000000,
        change: "RISE",
        changePrice: 29500.00000000,
        changeRate: 0.0504618543,
        signedChangePrice: 29500.00000000,
        signedChangeRate: 0.0504618543,
        tradeVolume: 0.48808720,
        accTradePrice: 23582664536.667096,
        accTradePrice24h: 111623431981.050845,
        accTradeVolume: 39638.24926752,
        accTradeVolume24h: 195374.18056495,
        highest52WeekPrice: 1044000.00000000,
        highest52WeekDate: "2024-04-05",
        lowest52WeekPrice: 392900.00000000,
        lowest52WeekDate: "2024-09-06",
        timestamp: 1741239227604
    ),
    MarketData(
        market: "KRW-AAVE",
        tradeDate: "20250306",
        tradeTime: "053347",
        tradeDateKst: "20250306",
        tradeTimeKst: "143347",
        tradeTimestamp: 1741239227291,
        openingPrice: 329150.00000000,
        highPrice: 357600.00000000,
        lowPrice: 326500.00000000,
        tradePrice: 352600.00000000,
        prevClosingPrice: 329150.00000000,
        change: "RISE",
        changePrice: 23450.00000000,
        changeRate: 0.0712441136,
        signedChangePrice: 23450.00000000,
        signedChangeRate: 0.0712441136,
        tradeVolume: 0.01937429,
        accTradePrice: 14000156419.91705,
        accTradePrice24h: 26510853340.023668,
        accTradeVolume: 40257.89256804,
        accTradeVolume24h: 78550.06841344,
        highest52WeekPrice: 588600.00000000,
        highest52WeekDate: "2024-12-24",
        lowest52WeekPrice: 103100.00000000,
        lowest52WeekDate: "2024-07-05",
        timestamp: 1741239227322
    ),
    MarketData(
        market: "KRW-DOGE",
        tradeDate: "20250306",
        tradeTime: "053347",
        tradeDateKst: "20250306",
        tradeTimeKst: "143347",
        tradeTimestamp: 1741239227375,
        openingPrice: 304.90000000,
        highPrice: 324.40000000,
        lowPrice: 301.00000000,
        tradePrice: 322.50000000,
        prevClosingPrice: 304.90000000,
        change: "RISE",
        changePrice: 17.60000000,
        changeRate: 0.0577238439,
        signedChangePrice: 17.60000000,
        signedChangeRate: 0.0577238439,
        tradeVolume: 62.03473945,
        accTradePrice: 46700377936.37249334,
        accTradePrice24h: 119325948580.61155441,
        accTradeVolume: 149075066.54963706,
        accTradeVolume24h: 389133014.50840087,
        highest52WeekPrice: 678.20000000,
        highest52WeekDate: "2024-12-08",
        lowest52WeekPrice: 116.70000000,
        lowest52WeekDate: "2024-08-05",
        timestamp: 1741239227420
    ),
    MarketData(
        market: "KRW-SHIB",
        tradeDate: "20250306",
        tradeTime: "053339",
        tradeDateKst: "20250306",
        tradeTimeKst: "143339",
        tradeTimestamp: 1741239219674,
        openingPrice: 0.01991000,
        highPrice: 0.02049000,
        lowPrice: 0.01972000,
        tradePrice: 0.02045000,
        prevClosingPrice: 0.01991000,
        change: "RISE",
        changePrice: 0.00054000,
        changeRate: 0.0271220492,
        signedChangePrice: 0.00054000,
        signedChangeRate: 0.0271220492,
        tradeVolume: 259551.00000000,
        accTradePrice: 6675850984.98468431,
        accTradePrice24h: 23427017265.66610959,
        accTradeVolume: 332448666276.43840809,
        accTradeVolume24h: 1180830429887.49330113,
        highest52WeekPrice: 0.05337000,
        highest52WeekDate: "2024-03-08",
        lowest52WeekPrice: 0.01571000,
        lowest52WeekDate: "2024-08-05",
        timestamp: 1741239219718
    ),
    MarketData(
        market: "KRW-MOVE",
        tradeDate: "20250306",
        tradeTime: "053346",
        tradeDateKst: "20250306",
        tradeTimeKst: "143346",
        tradeTimestamp: 1741239226783,
        openingPrice: 670.80000000,
        highPrice: 755.00000000,
        lowPrice: 651.00000000,
        tradePrice: 739.60000000,
        prevClosingPrice: 670.80000000,
        change: "RISE",
        changePrice: 68.80000000,
        changeRate: 0.1025641026,
        signedChangePrice: 68.80000000,
        signedChangeRate: 0.1025641026,
        tradeVolume: 408.99275836,
        accTradePrice: 37931851543.95080531,
        accTradePrice24h: 51900956187.7665969,
        accTradeVolume: 53315809.74526189,
        accTradeVolume24h: 75728723.64174597,
        highest52WeekPrice: 4250.00000000,
        highest52WeekDate: "2024-12-10",
        lowest52WeekPrice: 464.50000000,
        lowest52WeekDate: "2024-12-10",
        timestamp: 1741239226818
    ),
    MarketData(
        market: "KRW-CRO",
        tradeDate: "20250306",
        tradeTime: "053341",
        tradeDateKst: "20250306",
        tradeTimeKst: "143341",
        tradeTimestamp: 1741239221429,
        openingPrice: 119.60000000,
        highPrice: 138.10000000,
        lowPrice: 116.80000000,
        tradePrice: 127.00000000,
        prevClosingPrice: 119.60000000,
        change: "RISE",
        changePrice: 7.40000000,
        changeRate: 0.0618729097,
        signedChangePrice: 7.40000000,
        signedChangeRate: 0.0618729097,
        tradeVolume: 3366.28068520,
        accTradePrice: 21718635150.64902964,
        accTradePrice24h: 29822485605.47842841,
        accTradeVolume: 168523274.11634977,
        accTradeVolume24h: 238055795.76811883,
        highest52WeekPrice: 379.00000000,
        highest52WeekDate: "2024-11-11",
        lowest52WeekPrice: 96.84000000,
        lowest52WeekDate: "2024-11-04",
        timestamp: 1741239221463
    ),
    MarketData(
        market: "KRW-STPT",
        tradeDate: "20250306",
        tradeTime: "053346",
        tradeDateKst: "20250306",
        tradeTimeKst: "143346",
        tradeTimestamp: 1741239226953,
        openingPrice: 123.00000000,
        highPrice: 123.00000000,
        lowPrice: 115.60000000,
        tradePrice: 116.00000000,
        prevClosingPrice: 123.10000000,
        change: "FALL",
        changePrice: 7.10000000,
        changeRate: 0.0576766856,
        signedChangePrice: -7.10000000,
        signedChangeRate: -0.0576766856,
        tradeVolume: 465.21551768,
        accTradePrice: 16191825761.96094022,
        accTradePrice24h: 51619681204.11693295,
        accTradeVolume: 137452649.65020096,
        accTradeVolume24h: 437254235.60348272,
        highest52WeekPrice: 227.90000000,
        highest52WeekDate: "2025-01-26",
        lowest52WeekPrice: 49.22000000,
        lowest52WeekDate: "2024-08-05",
        timestamp: 1741239226982
    ),
    MarketData(
        market: "KRW-KAITO",
        tradeDate: "20250306",
        tradeTime: "053341",
        tradeDateKst: "20250306",
        tradeTimeKst: "143341",
        tradeTimestamp: 1741239221951,
        openingPrice: 2680.00000000,
        highPrice: 2792.00000000,
        lowPrice: 2590.00000000,
        tradePrice: 2622.00000000,
        prevClosingPrice: 2680.00000000,
        change: "FALL",
        changePrice: 58.00000000,
        changeRate: 0.0216417910,
        signedChangePrice: -58.00000000,
        signedChangeRate: -0.0216417910,
        tradeVolume: 80.09153318,
        accTradePrice: 28874047643.90214661,
        accTradePrice24h: 372351152596.21965162,
        accTradeVolume: 10781113.65519682,
        accTradeVolume24h: 126811661.54647265,
        highest52WeekPrice: 3619.00000000,
        highest52WeekDate: "2025-03-05",
        lowest52WeekPrice: 2040.00000000,
        lowest52WeekDate: "2025-03-05",
        timestamp: 1741239222001
    ),
    MarketData(
        market: "KRW-USDT",
        tradeDate: "20250306",
        tradeTime: "053345",
        tradeDateKst: "20250306",
        tradeTimeKst: "143345",
        tradeTimestamp: 1741239225847,
        openingPrice: 1490.00000000,
        highPrice: 1492.00000000,
        lowPrice: 1483.00000000,
        tradePrice: 1487.00000000,
        prevClosingPrice: 1490.00000000,
        change: "FALL",
        changePrice: 3.00000000,
        changeRate: 0.0020134228,
        signedChangePrice: -3.00000000,
        signedChangeRate: -0.0020134228,
        tradeVolume: 169.18277439,
        accTradePrice: 36987918822.84356026,
        accTradePrice24h: 144467226876.17734533,
        accTradeVolume: 24858823.49628087,
        accTradeVolume24h: 96654094.98962287,
        highest52WeekPrice: 1648.00000000,
        highest52WeekDate: "2025-02-03",
        lowest52WeekPrice: 1043.00000000,
        lowest52WeekDate: "2024-12-03",
        timestamp: 1741239225877
    ),
    MarketData(
        market: "KRW-USDC",
        tradeDate: "20250306",
        tradeTime: "053231",
        tradeDateKst: "20250306",
        tradeTimeKst: "143231",
        tradeTimestamp: 1741239151425,
        openingPrice: 1490.00000000,
        highPrice: 1493.00000000,
        lowPrice: 1484.00000000,
        tradePrice: 1486.00000000,
        prevClosingPrice: 1490.00000000,
        change: "FALL",
        changePrice: 4.00000000,
        changeRate: 0.0026845638,
        signedChangePrice: -4.00000000,
        signedChangeRate: -0.0026845638,
        tradeVolume: 6.72947510,
        accTradePrice: 294274536.65693229,
        accTradePrice24h: 925055582.91583087,
        accTradeVolume: 197611.24807319,
        accTradeVolume24h: 619258.45622368,
        highest52WeekPrice: 1689.00000000,
        highest52WeekDate: "2025-02-03",
        lowest52WeekPrice: 1302.00000000,
        lowest52WeekDate: "2024-09-30",
        timestamp: 1741239210919
    ),
    MarketData(
        market: "KRW-BTT",
        tradeDate: "20250306",
        tradeTime: "053321",
        tradeDateKst: "20250306",
        tradeTimeKst: "143321",
        tradeTimestamp: 1741239201454,
        openingPrice: 0.00107300,
        highPrice: 0.00117100,
        lowPrice: 0.00106600,
        tradePrice: 0.00111200,
        prevClosingPrice: 0.00107300,
        change: "RISE",
        changePrice: 0.00003900,
        changeRate: 0.0363466915,
        signedChangePrice: 0.00003900,
        signedChangeRate: 0.0363466915,
        tradeVolume: 615410052.02131420,
        accTradePrice: 14341636397.91938191,
        accTradePrice24h: 16821690260.79062946,
        accTradeVolume: 12840215535615.67007,
        accTradeVolume24h: 15155311716263.74249,
        highest52WeekPrice: 0.00266800,
        highest52WeekDate: "2024-03-09",
        lowest52WeekPrice: 0.00093240,
        lowest52WeekDate: "2024-08-05",
        timestamp: 1741239210351
    ),
    MarketData(
        market: "KRW-PEPE",
        tradeDate: "20250306",
        tradeTime: "053345",
        tradeDateKst: "20250306",
        tradeTimeKst: "143345",
        tradeTimestamp: 1741239225465,
        openingPrice: 0.01056000,
        highPrice: 0.01087000,
        lowPrice: 0.01039000,
        tradePrice: 0.01083000,
        prevClosingPrice: 0.01056000,
        change: "RISE",
        changePrice: 0.00027000,
        changeRate: 0.0255681818,
        signedChangePrice: 0.00027000,
        signedChangeRate: 0.0255681818,
        tradeVolume: 91453006.17819516,
        accTradePrice: 2737025238.51038568,
        accTradePrice24h: 8695877544.89970516,
        accTradeVolume: 257526679814.05270557,
        accTradeVolume24h: 820093637963.9377905,
        highest52WeekPrice: 0.06199000,
        highest52WeekDate: "2024-11-14",
        lowest52WeekPrice: 0.00953700,
        lowest52WeekDate: "2025-03-04",
        timestamp: 1741239225507
    )
]
