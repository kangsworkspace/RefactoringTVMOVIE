//
//  Enums.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

enum Section: Hashable {
    case double
    case banner
    case horizontal(String)
    case vertical(String)
}

enum Item: Hashable {
    case normal(TV)
    case normalMovie(Movie)
    case bigImage(Movie)
    case list(Movie)
}

enum LanguageType: String, Decodable {
    case korean = "ko"
    case english = "en"
}

enum MovieRequestType: Decodable {
    case upcoming
    case popular
    case nowPlaying
}
