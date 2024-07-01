//
//  Enums.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

enum MainSection: Hashable {
    case double
    case banner
    case horizontal(String)
    case vertical(String)
}

enum MainItem: Hashable {
    case normalTV(TV)
    case normalMovie(Movie)
    case bigImage(Movie)
    case list(Movie)
}

enum MovieRequestType: Decodable {
    case upcoming
    case popular
    case nowPlaying
}

enum ContentType: String, Decodable {
    case tv
    case movie
}

enum ReviewSection {
    case list
}

enum ReviewItem: Hashable {
    case header(ReviewHeader)
    case content(String)
}

struct ReviewHeader: Hashable {
    let id: String
    let name: String
    let url: String
}
