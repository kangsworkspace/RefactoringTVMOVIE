//
//  Network+Path.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

extension Network {
  func getPath() -> String {
    switch self {
    case .getTVList(let request):
        if request.query == "" {
            return "/tv/top_rated"
        } else {
            return "/search/tv"
        }
    case .getMovieList(let request):
        switch request.movieReqeustType {
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .upcoming:
            return "/movie/upcoming"
        }
    }
  }
}
