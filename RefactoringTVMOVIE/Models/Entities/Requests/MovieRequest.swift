//
//  MovieRequest.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

struct MovieRequest: Decodable {
    var language: LanguageType
    var movieReqeustType: MovieRequestType
    
    init(language: LanguageType = LanguageType.korean, movieReqeustType: MovieRequestType) {
        self.language = language
        self.movieReqeustType = movieReqeustType
    }
}
