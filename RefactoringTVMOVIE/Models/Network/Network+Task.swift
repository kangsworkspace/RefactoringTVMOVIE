//
//  Network+Task.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation
import Moya

extension Network {
    func getTask() -> Task {
        // API 키 값 가져오기
        guard let apiKey = Bundle.main.apiKey else {
            print("API 로드 실패")
            return .requestPlain
        }
        
        switch self {
        case .getTVList(let request):
            var parameters: [String: Any] = [
                "api_key": apiKey,
                "language": "ko",
            ]
            
            if request.page != nil {
                parameters["page"] = request.page
            }
            
            if request.query != nil {
                parameters["query"] = request.query
            }
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .getMovieList:
            let parameters: [String: Any] = [
                "api_key": apiKey,
                "language": "ko",
            ]

            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case .getReviewList:
            let parameters: [String: Any] = [
                "api_key": apiKey,
                "language": "en",
            ]
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
}
