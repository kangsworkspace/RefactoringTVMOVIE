//
//  MovieRequest.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

struct MovieRequest: Decodable {
    var movieReqeustType: MovieRequestType
    
    init(movieReqeustType: MovieRequestType) {
        self.movieReqeustType = movieReqeustType
    }
}
