//
//  NetworkManager.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func callRequest<T: Codable>(
        _ requestContent: URLRequestConvertible,
        completionHandler: @escaping (Result<T, AFError>, Int?) -> Void
    ) {
        AF.request(requestContent).responseDecodable(of: T.self) { response in
            completionHandler(response.result, response.response?.statusCode)
        }
    }
    
    func getErrorMessage(statusCode: Int?) -> String {
        guard let statusCode else { return "UNKNOWN_ERROR"}
        
        switch (statusCode) {
            // internal error code : 'NWE' stands for 'Network Error'
        case 400...428: return "NWE\(statusCode): 현재 서비스에서 문제가 발생했습니다. 담당자에게 문의해주세요."
            // internal error code : 'TMR' stands for 'Too Many Request to remote server', currently 30 times/ min is the limit of Gecko.
        case 429 : return "TMR: 동일한 IP에서 너무 많은 Request들이 감지되었어요. 조금 있다가 다시 이용해보세요."
        case 430...499 : return "NWE\(statusCode): 현재 서비스에서 문제가 발생했습니다. 담당자에게 문의해주세요."
            // internal error code : 'RSE' stands for 'Remote Server Error', this app rely on the 2 external data source.
        case 500...599 : return "현재 서버의 상태가 불안정하여 서비스를 이용할 수 없어요. 조금 있다가 다시 이용해보세요."
            // internal error code : 'IRE' stands for 'Investment Required Error', which is, unexpected error at this point.
        default: return "IRE\(statusCode): 예상치 못한 오류가 발생했습니다. 담당자에게 문의해주세요."
        }
    }
}

