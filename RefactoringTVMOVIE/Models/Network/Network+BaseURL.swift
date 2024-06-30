//
//  Network+BaseURL.swift
//  RefactoringTVMOVIE
//
//  Created by Healthy on 6/30/24.
//

import Foundation

extension Network {
  func getBaseURL() -> URL {
    return URL(string: "https://api.themoviedb.org/3")!
  }
}
