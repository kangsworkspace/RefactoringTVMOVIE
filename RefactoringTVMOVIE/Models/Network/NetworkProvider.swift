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
    
    func fetchMovie() -> Single<MovieResult> {
        let upcoming = fetchMovieUpcoming()
        let popular = fetchMoviePopular()
        let nowPlaying = fetchMovieNowPlaying()
           
        return Single.zip(upcoming, popular, nowPlaying) { upcoming, popular, nowPlaying in
            return MovieResult(upcoming: upcoming, popular: popular, nowPlaying: nowPlaying)
        }
    }
    
    func fetchReview(reviewRequest: ReviewRequest) -> Single<ReviewListModel> {
        return provider.rx.request(.getReviewList(reviewRequest))
            .map { response in
                print(response)
                let decoder = JSONDecoder()
                return try decoder.decode(ReviewListModel.self, from: response.data)
            }
    }

    private func fetchMovieUpcoming() -> Single<MovieListModel> {
        return provider.rx.request(.getMovieList(MovieRequest(movieReqeustType: .upcoming)))
            .map { response in
                let decoder = JSONDecoder()
                return try decoder.decode(MovieListModel.self, from: response.data)
            }
    }
    
    private func fetchMoviePopular() -> Single<MovieListModel> {
        return provider.rx.request(.getMovieList(MovieRequest(movieReqeustType: .popular)))
            .map { response in
                let decoder = JSONDecoder()
                return try decoder.decode(MovieListModel.self, from: response.data)
            }
    }
    
    private func fetchMovieNowPlaying() -> Single<MovieListModel> {
        return provider.rx.request(.getMovieList(MovieRequest(movieReqeustType: .nowPlaying)))
            .map { response in
                let decoder = JSONDecoder()
                return try decoder.decode(MovieListModel.self, from: response.data)
            }
    }
}
