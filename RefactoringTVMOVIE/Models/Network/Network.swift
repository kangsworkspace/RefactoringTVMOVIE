//
//  Network.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

import Moya

enum Network {
    case getTVList(TVRequest)
    case getMovieList(MovieRequest)
}

extension Network: TargetType {
    var baseURL: URL { self.getBaseURL() }
    var path: String { self.getPath() }
    var method: Moya.Method { self.getMethod() }
    var task: Task { self.getTask() }
    var headers: [String : String]? { return nil }
}
