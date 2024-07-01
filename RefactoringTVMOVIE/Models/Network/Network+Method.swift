//
//  Network+Method.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation
import Moya

extension Network {
    func getMethod() -> Moya.Method {
        switch self {
        case .getTVList:
            return .get
        case .getMovieList:
            return .get
        case .getReviewList:
            return .get
        }
    }
}
