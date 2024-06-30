//
//  NetworkProvider.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

import RxSwift
import RxMoya
import Moya

final class NetworkProvider {
    // MARK: - Fields
    static let shared = NetworkProvider()
    private let provider = MoyaProvider<Network>()
    
    
    private init() {}
    
    
    // MARK: - Functions
    func fetchTV(tvRequest: TVRequest) -> Single<TVListModel> {
        return provider.rx.request(.getTVList(tvRequest))
            .map { response in
                let decoder = JSONDecoder()
                return try decoder.decode(TVListModel.self, from: response.data)
            }
    }
}
