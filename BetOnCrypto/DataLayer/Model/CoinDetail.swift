//
//  CoinDetail.swift
//  SimpleWeather
//
//  Created by marty.academy on 3/7/25.
//

import Foundation

struct CoinDetail: Codable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double
    let marketCapRank: Int
    let fullyDilutedValuation: Double?
    let totalVolume: Double
    let high24h: Double?
    let low24h: Double?
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?
    let marketCapChange24h: Double?
    let marketCapChangePercentage24h: Double?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double
    let athChangePercentage: Double
    let athDate: String
    let atl: Double
    let atlChangePercentage: Double
    let atlDate: String
    let roi: CoinROI?
    let lastUpdated: String
    let sparklineIn7d: SparklineData?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
        case sparklineIn7d = "sparkline_in_7d"
    }
}

// MARK: - 코인 투자 수익률 정보
struct CoinROI: Codable {
    let times: Double?
    let currency: String?
    let percentage: Double?
}

// MARK: - 스파크라인 차트 데이터
struct SparklineData: Codable {
    let price: [Double]
}

let mockCoinDetail = CoinDetail(
    id: "bitcoin",
    symbol: "btc",
    name: "Bitcoin",
    image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    currentPrice: 16564.86,
    marketCap: 318198983557,
    marketCapRank: 1,
    fullyDilutedValuation: 347704617927,
    totalVolume: 17496786046,
    high24h: 16628.07,
    low24h: 16423.19,
    priceChange24h: 1.39,
    priceChangePercentage24h: 0.00841,
    marketCapChange24h: -82113402.73223877,
    marketCapChangePercentage24h: -0.0258,
    circulatingSupply: 19217975,
    totalSupply: 21000000,
    maxSupply: 21000000,
    ath: 69045,
    athChangePercentage: -76.01632,
    athDate: "2021-11-10T14:24:11.849Z",
    atl: 67.81,
    atlChangePercentage: 24320.76137,
    atlDate: "2013-07-06T00:00:00.000Z",
    roi: nil,
    lastUpdated: "2022-11-27T07:30:23.273Z",
    sparklineIn7d: SparklineData(
        price: [
            16695.34306727752, 16701.714438816867, 16726.174143970165, 16620.464779243754, 16652.176172793235,
            16624.699224336186, 16571.59968260733, 16563.656183392606, 16578.52534114607, 16566.279967373655,
            16600.24153665448, 16599.573939504007, 16561.594183007754, 16588.88217544183, 16572.673227419204,
            16527.127957427558, 16404.243066530144, 16308.812646583983, 16304.07685562355, 16233.508931320219,
            16229.013161337716, 16031.186769376665, 16064.001089561465, 16163.314134819153, 16185.298325953685,
            16111.728070055875, 16084.063614648307, 16031.918545533374, 16067.04558328075, 16130.595601614366,
            16089.63697072075, 16073.783909170232, 16214.037839455497, 16234.570924644582, 16163.378702587872,
            16052.862440419338, 16056.555207803576, 16000.304804972124, 15665.728828858591, 15835.072486141444,
            15734.494872016803, 15759.21495702581, 15794.327604914475, 15885.888268145578, 15823.642467902782,
            15813.484951266764, 15880.295908474383, 15835.25424768187, 15840.759180850695, 15758.848740937732,
            15748.64141743841, 15728.290575641106, 15700.60132213548, 15817.852304267795, 15745.692202511065,
            15832.85882041198, 16154.278025599786, 16111.42122464189, 16232.919812409002, 16200.157441280468,
            16116.357715823304, 16150.128749164089, 16191.113745792902, 16161.282188136152, 16162.157702942757,
            16176.97314581773, 16225.09189957465, 16209.596015309206, 16231.671031673663, 16512.41149262638,
            16568.96762222911, 16523.571951122372, 16508.916188082265, 16510.125819512763, 16602.0592699326,
            16551.215316568276, 16561.63682680324, 16622.990094437577, 16596.573301819506, 16537.799529752872,
            16476.1283274828, 16446.310798642244, 16419.594593702615, 16408.496095646035, 16373.700567791879,
            16495.491769334836, 16478.004530581038, 16562.384973654345, 16501.70819337447, 16530.49127394779,
            16633.46357404885, 16555.09819291426, 16753.6264666303, 16705.741702919928, 16712.223296490873,
            16692.317224983493, 16675.492413195687, 16693.167405345, 16687.03979038733, 16592.213656264223,
            16602.18990063926, 16562.828315758143, 16565.130787077218, 16542.108772805834, 16590.899604308124,
            16542.2388777077, 16575.77439856241, 16613.38351391628, 16609.76102385746, 16573.307829246267,
            16577.332433531647, 16575.1389930571, 16563.181446727078, 16601.992914953473, 16605.799294851015,
            16538.783859974512, 16541.18698294412, 16523.855447308633, 16510.215302989593, 16418.970640627897,
            16400.96439275418, 16425.963264152506, 16473.12367990774, 16443.89888043115, 16468.834753625473,
            16492.19577109786, 16539.275828400536, 16524.68652016038, 16496.052909480484, 16567.015292595217,
            16499.533717551763, 16477.197338150316, 16513.21338040719, 16482.58208581089, 16528.75518788924,
            16532.989921543045, 16525.096370371855, 16562.69686632468, 16521.12986806161, 16572.35337630616,
            16650.140631394148, 16638.016639204277, 16630.78388721838, 16626.314454893985, 16644.543971347666,
            16584.40256204829, 16574.887595442076, 16586.341327505826, 16603.33146933892, 16614.24981169916,
            16587.98553584422, 16581.757304380164, 16608.540153248436, 16549.159545310944, 16525.169706466455,
            16509.919025574694, 16532.0375291402, 16500.681652952197, 16528.372228198084, 16507.738024411636,
            16514.009167597753, 16423.189512843557, 16465.292555082957, 16479.10501433501, 16496.763746496472,
            16530.480329543443, 16535.240285290394, 16581.432615969083
        ]
    )
)
